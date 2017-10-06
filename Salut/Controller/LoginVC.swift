//
//  LoginVC.swift
//  Salut
//
//  Created by Israel Carvajal on 10/6/17.
//  Copyright © 2017 Israel Carvajal. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


}
