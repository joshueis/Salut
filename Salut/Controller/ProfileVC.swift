//
//  ProfileVC.swift
//  Salut
//
//  Created by Israel Carvajal on 11/3/17.
//  Copyright © 2017 Israel Carvajal. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameTF: UILabel!
    @IBOutlet weak var emailTF: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    @IBAction func logout(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: DATA_DID_CHANGE_NOTIF, object: nil)
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func exit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupView(){
        profileImg.image = UIImage(named: UserDataService.instance.avatarName)
        profileImg.backgroundColor = UserDataService.instance.getUIColor(components: UserDataService.instance.avatarColor)
        nameTF.text = UserDataService.instance.name
        emailTF.text = UserDataService.instance.email
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
        
        
    }
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }

}
