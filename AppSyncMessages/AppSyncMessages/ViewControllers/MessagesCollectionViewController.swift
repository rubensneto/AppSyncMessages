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
    
    var profile: Profile! {
        didSet{
            nameLabel.text = profile.name
            nameLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
            profileImageView.image =  UIImage(data: profile.profileImage!)
            setNavigationBar()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = optionsButton
        navigationController?.navigationBar.addSubview(navigationContainerView)
        navigationController?.navigationBar.bringSubview(toFront: navigationContainerView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationContainerView.removeFromSuperview()
    }
    
    @objc func optionsButtonAction(){
        
    }
    
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

    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }
    
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
