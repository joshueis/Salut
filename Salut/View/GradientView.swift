//
//  GradientView.swift
//  Salut
//
//  Created by Israel Carvajal on 10/5/17.
//  Copyright © 2017 Israel Carvajal. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var topColor : UIColor = #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 1){
        didSet{
            //update vew after it was set on interface builder
            self.setNeedsLayout()
        }
    }
    @IBInspectable var bottomColor : UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1){
        didSet{
            //update vew after it was set on interface builder
            self.setNeedsLayout()
        }
    }
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        //the gradient starts from top left
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        //the end of the effect goes to the bottom right
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        // the frame is the size of the layer, which matches the view at which we apply the layer
        gradientLayer.frame = self.bounds
        //add the layer to the view, at 0 being the first layer farther away in the z axis
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

}
