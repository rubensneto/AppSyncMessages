//
//  ChatBubbleCell.swift
//  AppSyncMessages
//
//  Created by Rubens Neto on 28/06/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import UIKit

class ChatBubbleCell: UICollectionViewCell {
    
    var message: Message! {
        didSet {
            messageTextView.text = message.text
            bubbleViewRightAnchor?.isActive = message.isSender
            bubbleViewLeftAnchor?.isActive = !message.isSender
            timestampLabel.text = message.timestamp!.getHourFromDate()
            timestampLeftAnchor?.isActive = message.isSender
            timestampRightAnchor?.isActive = !message.isSender
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
    
    var bubbleWidthAnchor: NSLayoutConstraint?
    var bubbleViewLeftAnchor: NSLayoutConstraint?
    var bubbleViewRightAnchor: NSLayoutConstraint?
    var timestampLeftAnchor: NSLayoutConstraint?
    var timestampRightAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        addSubview(bubbleView)
        addSubview(messageTextView)
        addSubview(timestampLabel)
        
        bubbleViewRightAnchor = bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10)
        bubbleViewLeftAnchor =  bubbleView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10)
        bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        bubbleWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 100)
        bubbleWidthAnchor?.isActive = true
        
        messageTextView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 6).isActive = true
        messageTextView.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 6).isActive = true
        messageTextView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
        messageTextView.bottomAnchor.constraint(equalTo: timestampLabel.topAnchor, constant: 1).isActive = true
        
        
        timestampLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        timestampLeftAnchor = timestampLabel.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 10)
        timestampRightAnchor = timestampLabel.rightAnchor.constraint(equalTo: bubbleView.rightAnchor, constant: -10)
        timestampLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -4).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}















