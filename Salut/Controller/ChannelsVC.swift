//
//  ChannelsVC.swift
//  Salut
//
//  Created by Israel Carvajal on 10/5/17.
//  Copyright © 2017 Israel Carvajal. All rights reserved.
//

import UIKit

class ChannelsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var channelTable: UITableView!
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        channelTable.delegate = self
        channelTable.dataSource = self
        //how wide we want the menu to be
        self.revealViewController().rearViewRevealWidth = self.view.frame.width - 60
        //handle notifications from create account vc with observer
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelsVC.userDataDidChange), name: DATA_DID_CHANGE_NOTIF, object: nil)
        //if channels are created we need to add them to our UI
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelsVC.channelsChanged), name: CHANNELS_CHANGE_NOTIF, object: nil)
        
        //listen to any channels added
        SocketService.instance.getChannel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }
    
    @IBAction func addChannel(_ sender: Any) {
        if AuthService.instance.isLogedIn{
            let channelVC = AddChannelVC()
            channelVC.modalPresentationStyle = .custom
            present(channelVC, animated: true, completion: nil)
        }
        else{
            HelpService.instance.createAlert(title: "Login Required", message: "To create a channel please login to your account, or sign up!", view: self)
            
        }
    }
    
    
    func setupUserInfo(){
        if AuthService.instance.isLogedIn{
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.getUIColor(components: UserDataService.instance.avatarColor)
        }else{
            loginBtn.setTitle("login", for: .normal)
            userImg.image = UIImage(named: "profileDefault")
            userImg.backgroundColor = UIColor.clear
            //if we are logged out channels are cleared so reload the table
            channelTable.reloadData()
            
        }
    }
    @objc func userDataDidChange(_ notif: Notification){
        setupUserInfo()
    }
    
    @objc func channelsChanged(_ notif: Notification){
        channelTable.reloadData()
    }
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLogedIn{
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        }
        else{
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    // MARK: - Populate channels table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MsgService.instance.channels.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelViewCell {
            let channel = MsgService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        }else{
            return ChannelViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MsgService.instance.channels[indexPath.row]
        MsgService.instance.selectedChannel = channel
        NotificationCenter.default.post(name: CHANNELS_SELECTED_NOTIF, object: nil)
        // close menu/channelVC after item is selected
        self.revealViewController().revealToggle(animated: true)
    }
    
}
