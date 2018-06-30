//
//  ConversationCell.swift
//  AppSyncMessages
//
//  Created by Rubens Neto on 25/06/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import UIKit
import CoreData

class ConversationCell: UICollectionViewCell {
    
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
        view.translatesAutoresizingMaskIntoConstraints = false
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Friend Name"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let messagePreviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Iron Fist is coming..."
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timestampLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellView()
        setupContainerView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellView(){
        self.layer.cornerRadius = 10
        backgroundColor = .reconDarkGray
        
        addSubview(onlineIndicatorView)
        
        onlineIndicatorView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        onlineIndicatorView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        onlineIndicatorView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        onlineIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        addSubview(profileImageView)
        
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 46).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 46).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setupContainerView(){
        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        
        containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 80).isActive = true
        containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true

        
        containerView.addSubview(nameLabel)
        containerView.addSubview(messagePreviewLabel)
        containerView.addSubview(timestampLabel)
        
        
        nameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        nameLabel.rightAnchor.constraint(greaterThanOrEqualTo: timestampLabel.leftAnchor, constant: -2).isActive = true
        
        timestampLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        timestampLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        
        messagePreviewLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        messagePreviewLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        messagePreviewLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10).isActive = true
    }
}

