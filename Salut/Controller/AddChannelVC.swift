//
//  AddChannelVC.swift
//  Salut
//
//  Created by Israel Carvajal on 11/14/17.
//  Copyright © 2017 Israel Carvajal. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    
    @IBOutlet weak var nameTF: ColoredPlaceHolder!
    @IBOutlet weak var descriptionTF: ColoredPlaceHolder!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }

    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
    
    @IBAction func createChannel(_ sender: Any) {
        guard let name = nameTF.text, nameTF.text != "" else {return}
        guard let description = descriptionTF.text , descriptionTF.text != "" else {return}
        SocketService.instance.addChannel(name: name, description: description) { (success) in
            if success{
                self.dismiss(animated: true, completion: nil)
            }else{
                HelpService.instance.createAlert(title: "Channel Not Creater", message: "Channel cannot be created at this time, please try again later", view: self)
            }
        }
        //        let channel = Channel(tittle: name, description: description, id: nil)
//        MsgService.instance.addChannel(channel: channel) { (success) in
//            if success{
//
//            }else{
//                HelpService.instance.createAlert(title: "Channel Not Creater", message: "Channel cannot be created at this time, please try again later", view: self)
//            }
//        }
    }
    func setupView(){
        //add gesture recognizer and reuse close tap function
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
}
