//
//  UserDataService.swift
//  Salut
//
//  Created by Israel Carvajal on 10/8/17.
//  Copyright © 2017 Israel Carvajal. All rights reserved.
//

import Foundation

class UserDataService{
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String, color: String, avtrName: String, email: String, name: String){
        self.id = id
        self.avatarColor = color
        self.avatarName = avtrName
        self.email = email
        self.name = name
    }
    func setAvatarName(avtrName: String){
        avatarName = avtrName
    }
    
    func getUIColor(components: String) -> UIColor{
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        var r, g, b, a : NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)

        let defaultColor = UIColor.lightGray
        
        guard let rUnwrapped = r else {return defaultColor}
        guard let gUnwrapped = g else {return defaultColor}
        guard let bUnwrapped = b else {return defaultColor}
        guard let aUnwrapped = a else {return defaultColor}
        
        let rfloat = CGFloat(rUnwrapped.doubleValue)
        let gfloat = CGFloat(gUnwrapped.doubleValue)
        let bfloat = CGFloat(bUnwrapped.doubleValue)
        let afloat = CGFloat(aUnwrapped.doubleValue)
        
        let uiColor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        return uiColor
    }
    
    func logoutUser(){
        id = ""
        avatarName = ""
        avatarColor = ""
        email = ""
        name = ""
        AuthService.instance.isLogedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
        MsgService.instance.clearChannels()
        
    }
}
