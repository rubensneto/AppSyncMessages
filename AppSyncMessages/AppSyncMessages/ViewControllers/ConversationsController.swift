//
//  ViewController.swift
//  AppSyncMessages
//
//  Created by Rubens Neto on 25/06/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import UIKit

class ConversationsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"

    //MARK: View Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationLayout()
        setupCollectionViewLayout()
    }
    
    //MARK: Collection View

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 70)
    }
    
    func setupCollectionViewLayout(){
        collectionView?.backgroundColor = .black
        collectionView?.register(ConversationCell.self, forCellWithReuseIdentifier: cellId)
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

