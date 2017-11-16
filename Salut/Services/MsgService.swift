//
//  MsgService.swift
//  Salut
//
//  Created by Israel Carvajal on 11/14/17.
//  Copyright © 2017 Israel Carvajal. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MsgService{
    static let instance = MsgService()
    var channels = [Channel]()
    var selectedChannel : Channel?
    var msgs = [String : [Message]]()
    
    
    
    func getMsgs(channel: Channel, completion: @escaping CompletionHandler){
        Alamofire.request("\(URL_GET_MESSAGE)\(channel.id)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                // response will be an array of
                if let json = JSON(data: data).array{
                    for item in json {
//                        let name = item["name"].stringValue
//                        let description = item["description"].stringValue
//                        let id = item["_id"].stringValue
//                        //create object to store in array
//                        let message = Message(tittle: , description: , id: )
                        self.channels.append(channel)
                        
                        
                    }
                    completion(true)
                }
                
                
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
//    func addChannel(channel: Channel, completion: @escaping CompletionHandler){
//        let body : [String:Any] = [
//            "name" : channel.tittle,
//            "description" : channel.description]
//        Alamofire.request(URL_ADD_CHANNEL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON{ (response) in
//            if response.result.error == nil{
//                completion(true)
//            }else{
//                completion(false)
//                debugPrint(response.error as Any)
//            }
//        }
//    }
    
    func findAllChannels(completion: @escaping CompletionHandler){
        Alamofire.request(URL_GET_CHANNEL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                /* Swift 4
                    This way of parsing using JSON decoder needs a model matching all properties of the json file
                    and the type need to match as well, it takes one line of code
                 do {
                 self.channels = try JSONDecoder().decode([Channel].self, from: data)
                 }catch let error{
                  debugPrint(error as Any)
                 }
                 */
                // response will be an array of dictionaries, each containing name, desc, and id for channel
                if let json = JSON(data: data).array{
                    for item in json {
                        let name = item["name"].stringValue
                        let description = item["description"].stringValue
                        let id = item["_id"].stringValue
                        //create object to store in array
                        let channel = Channel(tittle: name, description: description, id: id)
                        self.channels.append(channel)
                    }
                    NotificationCenter.default.post(name: CHANNELS_CHANGE_NOTIF, object: nil)
                    completion(true)
                }
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func clearChannels(){
        channels.removeAll()
    }
    
}
