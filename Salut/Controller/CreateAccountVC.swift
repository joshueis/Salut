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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //user data
    var avtrName = "profileDefault"
    var avtrColor = "[0.5, 0.5, 0.5, 1]" //set it to gray RGB color with alpha-> transparency
    var bgColor : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        view.addHideKbOnTouch()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //update if we have an avatar selected
        if UserDataService.instance.avatarName != ""{
            avtrName = UserDataService.instance.avatarName
            //avatar name mapped to image file name -> set it up
            userImg.image = UIImage(named: avtrName)
            if avtrName.contains("light") && bgColor == nil{
                userImg.backgroundColor = UIColor.lightGray
            }
        }
    }

    func setupView(){
        //hide the spinner initially
        spinner.isHidden = true
        //set up the color of the placeholder in textfields
        userNameTF.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: PURPLEPH])
        emailTF.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: PURPLEPH])
        //for password I'm using custom UITextField to show different approach
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR, sender: nil)
    }
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
        //generate a number to create colors
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        avtrColor = "[\(r), \(g), \(b), 1"
        self.userImg.backgroundColor = bgColor
        
    }
    
    @IBAction func createAccPressed(_ sender: Any) {
        
        //show spinner
        spinner.isHidden = false
        spinner.startAnimating()
        
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
                                //AuthService.instance.isLogedIn = true
                                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                //after user succesfully logs in, post it to notification center
                                NotificationCenter.default.post(name : DATA_DID_CHANGE_NOTIF, object: nil)
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
