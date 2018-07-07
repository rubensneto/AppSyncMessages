//
//  ViewController.swift
//  AppSyncMessages
//
//  Created by Rubens Neto on 25/06/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import UIKit
import CoreData

class ConversationsController: UICollectionViewController, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate {
    
    private let conversationCellId = "conversationCellId"
    private let searchCellId = "searchCellId"
    
    lazy var fetchedResultsController: NSFetchedResultsController<Profile> = {
        let fetchRequest = NSFetchRequest<Profile>(entityName: "Profile")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "lastMessage.timestamp", ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "lastMessage != nil")
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    //MARK: View Life Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = MessagesDataManager.shared
        do {
            try fetchedResultsController.performFetch()
        } catch let error {
            print(error)
        }
        setupNavigationLayout()
        setupCollectionViewLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }
    
    //MARK: Collection View

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = fetchedResultsController.sections?[0].numberOfObjects {
            return count + 1
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
           return collectionView.dequeueReusableCell(withReuseIdentifier: searchCellId, for: indexPath)
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: conversationCellId, for: indexPath) as! ConversationCell
        let profile = fetchedResultsController.object(at: IndexPath(row: indexPath.row - 1, section: 0))
        cell.message = profile.lastMessage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = MessagesCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        controller.profile = fetchedResultsController.object(at: IndexPath(row: indexPath.row - 1, section: 0))
        navigationController?.pushViewController(controller, animated: true)
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
    
    //MARK: Fetched Results Controller Delegate
    
    var blockOperations = [BlockOperation]()
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any,
                    at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if type == .insert {
            blockOperations.append(BlockOperation(block: {
                self.collectionView?.insertItems(at: [newIndexPath!])
            }))
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView?.performBatchUpdates({
            for operation in self.blockOperations {
                operation.start()
            }
            collectionView?.reloadData()
        })
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

