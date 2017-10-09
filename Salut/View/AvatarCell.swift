//
//  AvatarCell.swift
//  Salut
//
//  Created by Israel Carvajal on 10/8/17.
//  Copyright © 2017 Israel Carvajal. All rights reserved.
//

import Foundation

enum AvatarType{
    case dark
    case light
}

class AvatarCell: UICollectionViewCell{
    
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    func configCell(index: Int, type: AvatarType){
        if type == AvatarType.dark{
            avatarImg.image = UIImage(named: "dark\(index)")
        }else{
            avatarImg.image = UIImage(named: "light\(index)")
        }
    }
    
    func setUpView(){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
}
