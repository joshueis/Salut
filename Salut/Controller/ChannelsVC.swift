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
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    override func viewDidLoad() {
        super.viewDidLoad()
        //how wide we want the menu to be
        self.revealViewController().rearViewRevealWidth = self.view.frame.width - 60
    }
    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
}
