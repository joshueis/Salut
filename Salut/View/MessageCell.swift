//
//  MessageCell.swift
//  Salut
//
//  Created by Israel Carvajal on 11/16/17.
//  Copyright © 2017 Israel Carvajal. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var img: CircleImage!
    @IBOutlet weak var usrTF: UILabel!
    @IBOutlet weak var msgTF: UILabel!
    @IBOutlet weak var labelTF: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(msg: Message){
        msgTF.text = msg.message
        usrTF.text = msg.userName
        img.image = UIImage(named: msg.usrAvatar)
        img.backgroundColor = UserDataService.instance.getUIColor(components: msg.usrAvtrColor)
    }
}
