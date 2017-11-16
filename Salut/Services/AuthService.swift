//
//  AuthService.swift
//  Salut
//
//  Created by Israel Carvajal on 10/6/17.
//  Copyright © 2017 Israel Carvajal. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService{
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    var isLogedIn : Bool{
        get{
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set{
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    var authToken : String{
        get{
            return defaults.string(forKey: TOKEN_KEY)!
        }
        set{
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    var userEmail : String{
        get{
            return defaults.string(forKey: USER_EMAIL)!
        }
        set{
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, passw: String, completion: @escaping CompletionHandler){
        
        let lowerCaseEmail = email.lowercased()
        let body : [String:Any] = [
            "email" : lowerCaseEmail,
            "password" : passw]
        
        Alamofire.request(URL_REG, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil{
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser(email: String, passw: String, completion: @escaping CompletionHandler){
        
        let lowerCaseEmail = email.lowercased()
        let body : [String:Any] = [
            "email" : lowerCaseEmail,
            "password" : passw]
    
        Alamofire.request(URL_LOG, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON{ (response) in
            if response.result.error == nil{
                
                //using swifty JSON
                guard let data = response.data else {return}
                let json = JSON(data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                self.isLogedIn = true
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        
        }
        
    }
    
    func createUser(name: String, email:String, avtrName: String, color: String, completion: @escaping CompletionHandler){
        
        let lowerCaseEmail = email.lowercased()
        let body : [String:Any] = [
            "name" : name,
            "email" : lowerCaseEmail,
            "avatarName": avtrName,
            "avatarColor" : color]
        
        Alamofire.request(URL_ADD_USR, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON{ (response) in
            if response.result.error == nil{
                guard let data = response.data else {return}
                self.setUserInfo(data: data)
                completion(true)
            }else{
                completion(false)
                debugPrint(response.error as Any)
            }
        }
        
    }
    func findUserByEmail(completion: @escaping CompletionHandler){
        
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil{
                guard let data = response.data else {return}
                self.setUserInfo(data: data)
                //print(" asdf" + UserDataService.instance.avatarColor + UserDataService.instance.avatarName)
                completion(true)
            }else{
                completion(false)
                debugPrint(response.error as Any)
            }
        }
    }
    
    func setUserInfo(data: Data){
        let json = JSON(data: data)
        
        let id = json["_id"].stringValue
        let color = json["avatarColor"].stringValue
        let avtrName = json["avatarName"].stringValue
        let email = json["email"].stringValue
        let name = json["name"].stringValue
        
        UserDataService.instance.setUserData(id: id, color: color, avtrName: avtrName, email: email, name: name)
    }
    
}
