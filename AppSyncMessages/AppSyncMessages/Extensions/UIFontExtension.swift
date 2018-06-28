//
//  UIFontExtension.swift
//  AppSyncMessages
//
//  Created by Rubens Neto on 28/06/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import UIKit

extension UIFont {
    
    static let reconMessageText: UIFont = {
        return UIFont.systemFont(ofSize: 14, weight: .regular)
    }()
    
    static let reconMessageTimestamp: UIFont = {
        return UIFont.systemFont(ofSize: 10, weight: .regular)
    }()
    
    func heightOfString (string: String, constrainedToWidth width: CGFloat) -> CGFloat {
        return NSString(string: string).boundingRect(
            with: CGSize(width: width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: self],
            context: nil).size.height
    }
    
    func widthOfString (string: String, constrainedToHeight height: CGFloat) -> CGFloat {
        return NSString(string: string).boundingRect(
            with: CGSize(width: .greatestFiniteMagnitude, height: height),
            options: .usesLineFragmentOrigin,
            attributes: [.font: self],
            context: nil).size.width
    }
}
