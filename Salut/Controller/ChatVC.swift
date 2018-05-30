//
//  ChatVC.swift
//  Salut
//
//  Created by Israel Carvajal on 10/5/17.
//  Copyright © 2017 Israel Carvajal. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelLbl: UILabel!
    @IBOutlet weak var messageTF: ColoredPlaceHolder!
    @IBOutlet weak var msgTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        msgTable.delegate = self
        msgTable.dataSource = self
        //Allow messages to be completely display no matter what their length is
        msgTable.estimatedRowHeight = 80
        msgTable.rowHeight = UITableViewAutomaticDimension
        view.bindToKeyboard()
        view.addHideKbOnTouch()
        // MARK: - to use reveal View controller next
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        //end of Mark
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange), name: DATA_DID_CHANGE_NOTIF, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected), name: CHANNELS_SELECTED_NOTIF, object: nil)
        
        if AuthService.instance.isLogedIn {
            //In the case we are logged in and the up is open after being closed, retrieve user's info
            // send notification to populate ui
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: DATA_DID_CHANGE_NOTIF, object: nil)
            })
        }
    }
    
    @objc func channelSelected(_ notif: Notification){
        updateForChannel()
    }
    func updateForChannel(){
        let channelName = MsgService.instance.selectedChannel?.tittle ?? ""
        channelLbl.text = "#\(channelName)"
        getMessages()
    }
    @objc func userDataDidChange(_ notif: Notification){
        if AuthService.instance.isLogedIn{
            onLoginGetMessages()
        }else{
            HelpService.instance.createAlert(title: "Error", message: "Please Log In!", view: self)
        }
    }
    
    func onLoginGetMessages(){
        MsgService.instance.findAllChannels { (success) in
            if success{
                if MsgService.instance.channels.count > 0{//only if we have messages
                    MsgService.instance.selectedChannel = MsgService.instance.channels[0]
                    self.updateForChannel()
                }else{
                    self.channelLbl.text = "You Have No Channels"
                }
                
            }else{
                HelpService.instance.createAlert(title: "Error", message: "Failed retrieving channels!", view: self)
            }
        }
    }
    func getMessages(){
        guard let channelId = MsgService.instance.selectedChannel?.id else {return}
        MsgService.instance.getMsgsForChannel(channelId: channelId) { (success) in
            if success{
                self.msgTable.reloadData()
            }
        }
    }
    
    @IBAction func sendMsg(_ sender: Any) {
        if AuthService.instance.isLogedIn{
            guard let channelID = MsgService.instance.selectedChannel?.id else {return}
            guard let msg = messageTF.text, messageTF.text != "" else {return}
            SocketService.instance.addMessage(msg: msg, userID: UserDataService.instance.id, channelId: channelID)
            //clear text field and dismiss keyboard
            self.messageTF.text = ""
            self.messageTF.resignFirstResponder()
        }
        
        
    }
    
    // MARK: - Populate channels table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MsgService.instance.msgs.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "msgCell", for: indexPath) as? MessageCell {
            let msg = MsgService.instance.msgs[indexPath.row]
            cell.configCell(msg: msg)
            return cell
        }else{
            return MessageCell()
        }
    }
    
    

}
