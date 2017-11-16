//
//  HelpService.swift
//  Salut
//
//  Created by Israel Carvajal on 11/15/17.
//  Copyright © 2017 Israel Carvajal. All rights reserved.
//

import Foundation

class  HelpService{
    static let instance = HelpService()
    
    func createAlert(title: String, message: String, view: UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            view.dismiss(animated: true, completion: nil)
            
        }))
        
        view.present(alert, animated: true, completion: nil)
        
    }
  
    
}
