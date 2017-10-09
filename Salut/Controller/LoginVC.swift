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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginPressed(_ sender: Any) {
        
    
    }

    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func createAccntBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    

}
