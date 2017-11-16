//
//  CircleImage.swift
//  Salut
//
//  Created by Israel Carvajal on 10/20/17.
//  Copyright © 2017 Israel Carvajal. All rights reserved.
//

import UIKit

//shows on storyboard
@IBDesignable
class CircleImage: UIImageView {
    override func awakeFromNib() {
        setupView()
    }
 
    func setupView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }

}
