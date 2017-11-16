//
//  ChatVC.swift
//  Salut
//
//  Created by Israel Carvajal on 10/5/17.
//  Copyright © 2017 Israel Carvajal. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let channelName = MsgService.instance.selectedChannel?.tittle ?? ""
        channelLbl.text = "#\(channelName)"
    }
    @objc func userDataDidChange(_ notif: Notification){
        if AuthService.instance.isLogedIn{
            //get channels
            MsgService.instance.findAllChannels { (success) in
                if success{
                    debugPrint("find all channels run")
                }else{
                    HelpService.instance.createAlert(title: "Error", message: "Failed retrieving channels!", view: self)
                }
            }
        }
    }

}
