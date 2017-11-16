//
//  RoundedButton.swift
//  Salut
//
//  Created by Israel Carvajal on 10/8/17.
//  Copyright © 2017 Israel Carvajal. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        //self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        self.prepareForInterfaceBuilder()
        self.setupView()
    }
    func setupView(){
        self.layer.cornerRadius = cornerRadius
    }
}
