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
    
    var senderId: Int!
    var messages: [Message]?
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
        let width = UIScreen.main.bounds.width - 120
        let frame = CGRect(x: 60, y: 0, width: width, height: 44)
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
    
    func setupInputComponents(){
        let containerView = UIView()
        containerView.backgroundColor = .reconDarkBackground
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let sendButton = UIButton()
        sendButton.backgroundColor = .red
        sendButton.layer.cornerRadius = 19
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        let textField = UITextField()
        textField.placeholder = "Type a message"
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        containerView.addSubview(sendButton)
        containerView.addSubview(textField)
        
        // Constraints
        
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        sendButton.heightAnchor.constraint(equalToConstant: 38).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 38).isActive = true
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        textField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20).isActive = true
        textField.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: 20).isActive = true
        textField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    }
    
    //MARK: View Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        senderId = UserDefaults.standard.value(forKey: "userId") as! Int
        navigationItem.rightBarButtonItem = optionsButton
        navigationController?.navigationBar.addSubview(navigationContainerView)
        navigationController?.navigationBar.bringSubview(toFront: navigationContainerView)
        setupCollectionViewLayout()
        setupInputComponents()
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
            cell.bubbleWidthAnchor?.constant = estimateFrameFor(string: message.text!).width + 22
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 80
        if let message = messages?[indexPath.row] {
            height = estimateFrameFor(string: message.text!).height
        }
        let paddingConstraints: CGFloat = 6 + 1 + 12 + 4
        return CGSize(width: view.frame.width, height: height + paddingConstraints)
    }
    
    func estimateFrameFor(string: String) -> CGRect {
        let size = CGSize(width: view.bounds.width - 120, height: 1000)
        return NSString(string: string).boundingRect(
            with: size,
            options: .usesLineFragmentOrigin,
            attributes: [.font: UIFont.reconMessageText],
            context: nil)
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
        
        profileImageView.centerYAnchor.constraint(equalTo: navigationContainerView.centerYAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: navigationContainerView.centerYAnchor).isActive = true
        
    }
    
    func setupCollectionViewLayout(){
        collectionView?.backgroundColor = .black
        collectionView?.register(ChatBubbleCell.self, forCellWithReuseIdentifier: chatBubbleCellId)
        collectionView?.alwaysBounceVertical = true
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        collectionView?.collectionViewLayout = layout
        collectionView?.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
}































