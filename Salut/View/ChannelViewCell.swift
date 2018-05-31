//
//  ChannelViewCell.swift
//  Salut
//
//  Created by Israel Carvajal on 11/14/17.
//  Copyright © 2017 Israel Carvajal. All rights reserved.
//

import UIKit

class ChannelViewCell: UITableViewCell {

    @IBOutlet weak var channelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            // don't forget to select non in selection attribute for cell in instpector
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        }else{
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
        // Configure the view for the selected state
    }
    
    func configureCell(channel: Channel){
        // ?? if not found or nil then do ""
        let tittle = channel.tittle ?? ""
        channelName.text = "#\(tittle)"
        
        //set default font to be able to distinguish it from bold font when channel has new items
        channelName.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        //if the channel has unread messages then bold it's name
        if MsgService.instance.unreadChannels.contains(channel.id){
            channelName.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
        }
    }

}
