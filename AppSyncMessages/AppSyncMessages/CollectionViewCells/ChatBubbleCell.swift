//
//  ChatBubbleCell.swift
//  AppSyncMessages
//
//  Created by Rubens Neto on 28/06/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import UIKit

enum MessageType: Int {
    case text = 0
    case image = 1
}

enum MessageOrigin: Int {
    case incoming = 0
    case outgoing = 1
}

class ChatBubbleCell: T101Cell {
    
    var messageType: MessageType!
    var messageOrigin: MessageOrigin!
    
    var message: Message! {
        didSet {
            let userId = UserDefaults.standard.value(forKey: "userId") as! Int
            userId == Int(message.profile!.id) ? (messageOrigin = .outgoing) : (messageOrigin = .incoming)
            if let text = message.text {
                messageType = .text
                messageTextView.text = text
            }
            timestampLabel.text = message.timestamp!.getHourFromDate()
        }
    }
    
    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = .reconDarkBackground
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = UIFont.reconMessageText
        textView.textColor = .white
        textView.contentInset = UIEdgeInsetsMake(-10, -5, 0, 0)
        return textView
    }()
    
    let timestampLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.reconMessageTimestamp
        label.textColor = .reconDarkGrayText
        return label
    }()
    
    override func setupCellView() {
        super.setupCellView()
        self.backgroundColor = .clear
        addSubview(bubbleView)
        addSubview(messageTextView)
        addSubview(timestampLabel)
    }
}
