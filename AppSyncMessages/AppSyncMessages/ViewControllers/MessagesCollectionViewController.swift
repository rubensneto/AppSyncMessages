//
//  MessagesCollectionViewController.swift
//  AppSyncMessages
//
//  Created by Rubens Neto on 27/06/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MessagesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let chatBubbleCellId = "chatBubbleCellId"
    
    var profile: Profile! {
        didSet{
            nameLabel.text = profile.name
            nameLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
            profileImageView.image =  UIImage(data: profile.profileImage!)
            
            setNavigationBar()
            
            messages = profile.messages?.allObjects as? [Message]
            messages = messages?.sorted(by:{ $0.timestamp! < $1.timestamp!})
        }
    }
    
    var messages: [Message]?
    
    let optionsButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(named: "optionsButton")
        button.style = .plain
        button.tintColor = .white
        button.target = self as AnyObject
        button.action = #selector(optionsButtonAction)
        button.customView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return button
        
    }()
    
    let navigationContainerView: UIView = {
        let frame: CGRect = CGRect(x: 60, y: 0, width: UIScreen.main.bounds.width - 120, height: 44)
        let view = UIView(frame: frame)
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 18
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    //MARK: View Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = optionsButton
        navigationController?.navigationBar.addSubview(navigationContainerView)
        navigationController?.navigationBar.bringSubview(toFront: navigationContainerView)
        setupCollectionViewLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationContainerView.removeFromSuperview()
    }
    
    //MARK: User Actions
    
    @objc func optionsButtonAction(){
        
    }
    

    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messages?.count {
            return count
        }
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: chatBubbleCellId, for: indexPath) as! ChatBubbleCell
        if let message = messages?[indexPath.row] {
            cell.message = message
            let estimatedSize = NSString(string: message.text!).boundingRect(
                with: CGSize(width: 250, height: CGFloat.greatestFiniteMagnitude),
                options: .usesLineFragmentOrigin,
                attributes: [.font: UIFont.reconMessageText],
                context: nil).size
            let textViewHeight = UIFont.reconMessageText.heightOfString(string: message.text!, constrainedToWidth: 250)
            cell.bubbleView.frame = CGRect(x: 10, y: 0, width: estimatedSize.width + 20, height: cell.frame.height)
            cell.messageTextView.frame = CGRect(x: 20, y: 8, width: estimatedSize.width, height: textViewHeight)
            cell.timestampLabel.frame = CGRect(x: 20, y: cell.messageTextView.frame.height + 10, width: 250, height: 12)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let message = messages?[indexPath.row] {
            let textViewHeight = UIFont.reconMessageText.heightOfString(string: message.text!, constrainedToWidth: 250)
            let timestampHeight: CGFloat = 12
            let verticalPadding: CGFloat = 16
            return CGSize(width: view.frame.width, height: textViewHeight + timestampHeight + verticalPadding)
        }
        return CGSize(width: 0, height: 0)
    }
    
    //MARK: Styling
    
    func setNavigationBar(){
        navigationItem.titleView?.addSubview(navigationContainerView)
        navigationContainerView.addSubview(nameLabel)
        navigationContainerView.addSubview(profileImageView)
        
        navigationController?.navigationBar.addConstraintsWith(format: "H:|-43-[v0]-43-|", views: navigationContainerView)
        navigationController?.navigationBar.addConstraintsWith(format: "H:|[v0(44)]-2-|", views: navigationContainerView)
        navigationContainerView.addConstraintsWith(format: "H:|[v0]-(>=2)-[v1(36)]-0-|", views: nameLabel, profileImageView)
        navigationContainerView.addConstraintsWith(format: "V:[v0(36)]", views: profileImageView)
        navigationContainerView.addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .centerY, relatedBy: .equal, toItem: navigationContainerView, attribute: .centerY, multiplier: 1, constant: 0))
        navigationContainerView.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .centerY, relatedBy: .equal, toItem: navigationContainerView, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    func setupCollectionViewLayout(){
        collectionView?.backgroundColor = .black
        collectionView?.register(ChatBubbleCell.self, forCellWithReuseIdentifier: chatBubbleCellId)
        collectionView?.alwaysBounceVertical = true
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        collectionView?.collectionViewLayout = layout
    }
}































