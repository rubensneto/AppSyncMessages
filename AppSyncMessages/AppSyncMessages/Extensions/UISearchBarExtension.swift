//
//  UISearchBarExtension.swift
//  AppSyncMessages
//
//  Created by Rubens Neto on 26/06/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import UIKit

extension UISearchBar {
    func setBarTextField(color: UIColor){
        reachTextField { (textField) in
            textField.backgroundColor = color
        }
    }
    
    func setBarTextField(cornerRadius: CGFloat){
        reachTextField { (textField) in
            textField.layer.masksToBounds = true
            textField.layer.cornerRadius = cornerRadius
        }
    }
    
    func setBarTextField(textColor: UIColor){
        reachTextField { (textField) in
            textField.textColor = textColor
        }
    }
        
    func reachTextField(completion:(_ textField: UITextField)->()){
        for view in self.subviews {
            for subview in view.subviews {
                if let barTextField = subview as? UITextField {
                    completion(barTextField)
                }
            }
        }
    }
}
