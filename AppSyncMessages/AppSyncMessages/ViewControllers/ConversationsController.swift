//
//  ViewController.swift
//  AppSyncMessages
//
//  Created by Rubens Neto on 25/06/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import UIKit

class ConversationsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let conversationCellId = "conversationCellId"
    private let searchCellId = "searchCellId"
    
    let dataSource = ConversationsDataSource()

    //MARK: View Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationLayout()
        setupCollectionViewLayout()
    }
    
    //MARK: Collection View

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dataSource.messages.count > 0 {
            return dataSource.messages.count + 1
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
           return collectionView.dequeueReusableCell(withReuseIdentifier: searchCellId, for: indexPath)
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: conversationCellId, for: indexPath) as! ConversationCell
        cell.message = dataSource.messages[indexPath.row - 1] as! Message
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: view.frame.width, height: 55)
        }
        return CGSize(width: view.frame.width - 20, height: 70)
    }
    
    func setupCollectionViewLayout(){
        collectionView?.backgroundColor = .black
        collectionView?.register(ConversationCell.self, forCellWithReuseIdentifier: conversationCellId)
        collectionView?.register(SearchCell.self, forCellWithReuseIdentifier: searchCellId)
        collectionView?.alwaysBounceVertical = true
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        collectionView?.collectionViewLayout = layout
    }
    
    //MARK: Navigation
    
    func setupNavigationLayout(){
        navigationItem.title = "Messages"
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .reconRed
    }
}

