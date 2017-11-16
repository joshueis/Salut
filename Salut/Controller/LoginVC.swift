//
//  LoginVC.swift
//  Salut
//
//  Created by Israel Carvajal on 10/6/17.
//  Copyright © 2017 Israel Carvajal. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var userTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let email = userTF.text, userTF.text != "" else {return}
        guard let pass = passTF.text, passTF.text != "" else {return}
        
        //print("login email: " + email)
        AuthService.instance.loginUser(email: email, passw: pass) { (success) in
            if success{
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success{
                        NotificationCenter.default.post(name: DATA_DID_CHANGE_NOTIF, object: nil)
                        self.spinner.stopAnimating()
                        self.spinner.isHidden = true
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        HelpService.instance.createAlert(title: "Login failed!", message: "Error with server, please try again!", view: self)
                        self.spinner.stopAnimating()
                        self.spinner.isHidden = true
                    }
                })
            }else{
                HelpService.instance.createAlert(title: "Login failed!", message: "Invalid username or password!", view: self)
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
            }
        }
        
    }

    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func createAccntBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    func setupView(){
        spinner.isHidden = true
    }
    // added functions
    

}
