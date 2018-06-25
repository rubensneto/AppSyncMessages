//
//  UIViewExtension.swift
//  AppSyncMessages
//
//  Created by Rubens Neto on 25/06/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraintsWith(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
    }
}
