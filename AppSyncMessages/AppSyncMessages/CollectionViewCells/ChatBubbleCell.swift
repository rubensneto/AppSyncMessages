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

enum BubbleType: Int {
    case first = 0
    case subsequent = 1
}

class ChatBubbleCell: UICollectionViewCell {
    
    var messageType: MessageType!
    var messageOrigin: MessageOrigin!
    
    var bubbleType: BubbleType!
    
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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var bubbleWidthAnchor: NSLayoutConstraint?
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = UIFont.reconMessageText
        textView.textColor = .white
        textView.contentInset = UIEdgeInsets(top: -8, left: -1, bottom: 0, right: 0)
        textView.isUserInteractionEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let timestampLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.reconMessageTimestamp
        label.textColor = .reconDarkGrayText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        addSubview(bubbleView)
        addSubview(messageTextView)
        addSubview(timestampLabel)
        
        bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        bubbleWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 250)
        bubbleWidthAnchor?.isActive = true
        
        messageTextView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 6).isActive = true
        messageTextView.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 6).isActive = true
        messageTextView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
        messageTextView.bottomAnchor.constraint(equalTo: timestampLabel.topAnchor, constant: 1).isActive = true
        
        
        timestampLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        timestampLabel.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 10).isActive = true
        timestampLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -6).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
