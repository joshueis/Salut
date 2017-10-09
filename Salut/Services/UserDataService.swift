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
}
