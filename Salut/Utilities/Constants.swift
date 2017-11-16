//
//  Constants.swift
//  Salut
//
//  Created by Israel Carvajal on 10/5/17.
//  Copyright © 2017 Israel Carvajal. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let TO_AVATAR = "toAvatarPicker"
let UNWIND = "unwindToChannel"
// User Defaults
let TOKEN_KEY = "token"
let USER_EMAIL = "userEmail"
let LOGGED_IN_KEY = "loggedIn"

// for requests
let BASE_URL = "https://ira-salut.herokuapp.com/v1/"
let URL_REG = "\(BASE_URL)account/register"
let URL_LOG = "\(BASE_URL)account/login"
let URL_ADD_USR = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNEL = "\(BASE_URL)channel"
let URL_ADD_CHANNEL = "\(BASE_URL)channel/add"
let URL_GET_MESSAGE = "\(BASE_URL)message/byChannel"
//Notifications
let DATA_DID_CHANGE_NOTIF = Notification.Name("notifUserDataChanged")
let CHANNELS_CHANGE_NOTIF = Notification.Name("channelsChanged")
let CHANNELS_SELECTED_NOTIF = Notification.Name("channelSelected")

//headers

let HEADER = ["Content-Type" : "application/json; charset=utf-8"]
let BEARER_HEADER = [
    "Authorization" : "Bearer \(AuthService.instance.authToken)",
    "Content-Type" : "application/json; charset=utf-8"
]

//colors
let PURPLEPH = #colorLiteral(red: 0.3254901961, green: 0.4196078431, blue: 0.7764705882, alpha: 0.5)
