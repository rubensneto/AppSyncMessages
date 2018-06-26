//
//  ConversationCell.swift
//  AppSyncMessages
//
//  Created by Rubens Neto on 25/06/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import UIKit
import CoreData

class ConversationCell: T101Cell {
    
    var message: Message! {
        didSet{
            let profile = message.profile!
            onlineIndicatorView.alpha = (profile.isOnline) ? 1 : 0
            profileImageView.image = UIImage(data: profile.profileImage!)
            nameLabel.text = profile.name
            messagePreviewLabel.text = message.text
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm"
            timestampLabel.text = formatter.string(from: message.timestamp!)
            
        }
    }
    
    let onlineIndicatorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        view.backgroundColor = .reconGreen
        view.alpha = 0
        return view
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 23
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .red
        imageView.layer.borderColor = UIColor.reconDarkGray.cgColor
        imageView.layer.borderWidth = 2
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Friend Name"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    let messagePreviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Iron Fist is coming..."
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    let timestampLabel: UILabel = {
        let label = UILabel()
        label.text = "9:31"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    override func setupCellView(){
        self.layer.cornerRadius = 10
        backgroundColor = .reconDarkGray
        setupContainerView()
        
        addSubview(onlineIndicatorView)
        addConstraintsWith(format: "H:|-10-[v0(50)]", views: onlineIndicatorView)
        addConstraintsWith(format: "V:[v0(50)]", views: onlineIndicatorView)
        addConstraint(NSLayoutConstraint(item: onlineIndicatorView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addSubview(profileImageView)
        addConstraintsWith(format: "H:|-12-[v0(46)]", views: profileImageView)
        addConstraintsWith(format: "V:[v0(46)]", views: profileImageView)
        addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    func setupContainerView(){
        let containerView = UIView()
        containerView.backgroundColor = UIColor(red: 0.16, green: 0.16, blue: 0.16, alpha: 1)
        addSubview(containerView)
        
        addConstraintsWith(format: "H:|-80-[v0]-10-|", views: containerView)
        addConstraintsWith(format: "V:|-10-[v0]-10-|", views: containerView)
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(messagePreviewLabel)
        containerView.addSubview(timestampLabel)
        addConstraintsWith(format: "H:|[v0]-(>=2)-[v1]-0-|", views: nameLabel, timestampLabel)
        addConstraintsWith(format: "V:|[v0]-5-[v1]", views: nameLabel, messagePreviewLabel)
        addConstraintsWith(format: "V:|[v0]", views: timestampLabel)
        addConstraintsWith(format: "H:|[v0]-(>=2)-[v1]", views: messagePreviewLabel, timestampLabel)
        
    }
}

