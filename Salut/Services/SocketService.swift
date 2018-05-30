//
//  SocketService.swift
//  Salut
//
//  Created by Israel Carvajal on 11/15/17.
//  Copyright © 2017 Israel Carvajal. All rights reserved.
//

import UIKit
import SocketIO
class SocketService: NSObject {
    static let instance = SocketService()
    
    override init(){
        super.init()
    }
    
    var socket : SocketIOClient = SocketIOClient(socketURL: URL(string: BASE_URL)!)
    
    func connect(){
        socket.connect()
    }
    
    func disconnect(){
        socket.disconnect()
    }
    //use sockets for chanel creation
    func addChannel(name: String, description: String, completion: @escaping CompletionHandler ){
        socket.emit("newChannel", name, description)
        completion(true)
        
    }
    
    //could use completion handler as findAllChannels()
    func getChannel(){
        //listen to new channels added on user's group
        socket.on("channelCreated") { (dataArray, ack) in
            guard let name = dataArray[0] as? String else {return}
            guard let description = dataArray[1] as? String else {return}
            guard let id = dataArray[2] as? String else {return}
            let channel = Channel(tittle: name, description: description, id: id)
            MsgService.instance.channels.append(channel)
            NotificationCenter.default.post(name: CHANNELS_CHANGE_NOTIF, object: nil)
        }
            
        
    }
    func addMessage(msg: String, userID: String, channelId: String){
        let usr = UserDataService.instance
        socket.emit("newMessage", with: [msg, userID, channelId, usr.name, usr.avatarName, usr.avatarColor])
        //completion(true)
    }
    
}
