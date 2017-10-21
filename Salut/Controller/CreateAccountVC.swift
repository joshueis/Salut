//
//  CreateAccountVC.swift
//  Salut
//
//  Created by Israel Carvajal on 10/6/17.
//  Copyright © 2017 Israel Carvajal. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    //user data
    var avtrName = "profileDefault"
    var avtrColor = "[0.5, 0.5, 0.5, 1]" //set it to gray
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    //
    override func viewDidAppear(_ animated: Bool) {
        
        //update if we have an avatar selected
        if UserDataService.instance.avatarName != ""{
            avtrName = UserDataService.instance.avatarName
            //avatar name mapped to image file name -> set it up
            userImg.image = UIImage(named: avtrName)
            
        }
        
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR, sender: nil)
    }
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
        
    }
    
    @IBAction func createAccPressed(_ sender: Any) {
        
        //unwrap optionals with guard let, the come states the where clause
        guard let name = userNameTF.text, userNameTF.text != "" else {return}
        guard let email = emailTF.text , emailTF.text != "" else {return}
        guard let pass = passwordTF.text, passwordTF.text != "" else {return}
        
        AuthService.instance.registerUser(email: email, passw: pass, completion: { (success) in
            if (success){
                AuthService.instance.loginUser(email: email, passw: pass, completion: { (success) in
                    if (success){
                        AuthService.instance.createUser(name: name, email: email, avtrName: self.avtrName, color: self.avtrColor, completion: { (success) in
                            if(success){
                                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                            }                        
                            
                        })
                        print("user logged in!", AuthService.instance.authToken)
                    }
                })
            }
            print("User registered!")
        })
    }
    
    

}
