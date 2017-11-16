//
//  ColoredPlaceHolder.swift
//  Salut
//
//  Created by Israel Carvajal on 10/20/17.
//  Copyright © 2017 Israel Carvajal. All rights reserved.
//

import UIKit

class ColoredPlaceHolder: UITextField {

    override func awakeFromNib() {
        setupView()
    }
    
    func setupView(){
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: PURPLEPH])
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    

}
