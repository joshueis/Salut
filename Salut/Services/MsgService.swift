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
    var msgs = [Message]()
    var unreadChannels = [String]()
    
    func getMsgsForChannel(channelId: String, completion: @escaping CompletionHandler){
        Alamofire.request("\(URL_GET_MESSAGE)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                // response will be an array of
                if let json = JSON(data: data).array{
                    //clear messages, perhaps from previous channels
                    self.clearMessages()
                    for item in json {
                        let msgBody = item["messageBody"].stringValue
                        let channelId = item["channeId"].stringValue
                        let id = item["_id"].stringValue
                        let usrName = item["userName"].stringValue
                        let usrAvtr = item["userAvatar"].stringValue
                        let usrAvtrColor = item["userAvatarColor"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        
                        //create object to store in array
                        let message = Message(userName: usrName, channelId: channelId, usrAvatar: usrAvtr, usrAvtrColor: usrAvtrColor, userId: id, message: msgBody, timeStamp: timeStamp)
                        self.msgs.append(message)
                        
                    }
                    completion(true)
                }
            }else{
                completion(false)
                print("Here failed at trying to get messages")
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
                    and the type needs to match as well, it takes one line of code
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
   
    func clearMessages(){
        msgs.removeAll()
    }
    func clearChannels(){
        channels.removeAll()
    }
    
}
