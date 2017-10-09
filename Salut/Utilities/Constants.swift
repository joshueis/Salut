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


//headers

let HEADER = ["Content-Type" : "application/json; charset=utf-8"]
