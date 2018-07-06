//
//  MessagesDataManager.swift
//  AppSyncMessages
//
//  Created by Rubens Neto on 26/06/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import UIKit
import CoreData

class MessagesDataManager: CoreDataManager {
    
    static let shared: MessagesDataManager = {
        return MessagesDataManager()
    }()
    
    var messages: [Message]? = [Message]()
    
    override init(){
        super.init()
        
        clear()
        
        if let luiz = ProfileDataManager.shared.createProfile(name: "Luiz Mota", id: 11111, image: UIImage(named: "LoginBackground1")!, isOnline: true) {
            _ = createMessage(text: "We should be doing Unit Tests...", profile: luiz, date: Date(), isSender: false)
        }
        
        if let chris = ProfileDataManager.shared.createProfile(name: "Chris Schumann", id: 22222, image: UIImage(named: "LoginBackground2")!, isOnline: false) {
            _ = createMessage(text: "I can't, I have kids!!!", profile: chris, date: Date(timeInterval: -60, since: Date()), isSender: false)
        }
        
        if let brett = ProfileDataManager.shared.createProfile(name: "Brett Schumann", id: 33333, image: UIImage(named: "LoginBackground3")!, isOnline: false) {
            _ = createMessage(text: "Living is winning!", profile: brett, date: Date(timeInterval: -120, since: Date()), isSender: false)
        }
        
        if let rubens = ProfileDataManager.shared.createProfile(name: "Rubens Neto", id: 44444, image: UIImage(named: "LoginBackground4")!, isOnline: false) {
            _ = createMessage(text: "Pub?", profile: rubens, date: Date(timeInterval: -180, since: Date()), isSender: false)
        }
        
        if let tibo = ProfileDataManager.shared.createProfile(name: "TiBo", id: 55555, image: UIImage(named: "LoginBackground5")!, isOnline: true) {
            _ = createMessage(text: "Do you have any pain killers?", profile: tibo, date: Date(timeInterval: -240, since: Date()), isSender: false)
            _ = createMessage(text: "Hey TiBo! Don't worry man, everything is gonna be alright, how can I help you?", profile: tibo, date: Date(timeInterval: -270, since: Date()), isSender: true)
            _ = createMessage(text: "I'm totally in pain for more than a month now and this fucking sucks!!! I'm not kidding, I'm gonna kill someone.", profile: tibo, date: Date(timeInterval: -300, since: Date()), isSender: false)
        }
        
        fetchMessagesInLocalStorage()
    }
    
    
    //MARK: Entities Methods
    
    func createMessage(text: String, profile: Profile, date: Date, isSender: Bool) -> Message? {
        var id: String!
        let userId = UserDefaults.standard.value(forKey: "userId") as! Int
        
        isSender ?
            (id = String(describing: userId) + String(describing: profile.id) + String(describing: date)) :
            (id = String(describing: profile.id) + String(describing: userId) + String(describing: date))
        
        if !checkForExintingMessage(id: id!){
            let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context!) as! Message
            message.text = text
            message.timestamp = date
            message.isSender = isSender
            message.profile = profile
            message.id = id
            
            profile.lastMessage = message
            saveContext()
            return message
        }
        return nil
    }
    
    //MARK: Fetch Methods
    
    private func fetchMessagesInLocalStorage(){
        if let profiles = ProfileDataManager.shared.fetchProfiles() {
            for profile in profiles {
                print(profile.name!)
                let fetchRequest = NSFetchRequest<Message>(entityName: "Message")
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
                fetchRequest.predicate = NSPredicate(format: "profile.id = %ld", profile.id)
                fetchRequest.fetchLimit = 1
                do {
                    let fetchedMessages = try context!.fetch(fetchRequest)
                    messages?.append(contentsOf: fetchedMessages)
                } catch let error {
                    print(error)
                }
            }
        }
        messages = messages?.sorted(by:{ $0.timestamp! > $1.timestamp!})
    }
    
    private func checkForExintingMessage(id: String) -> Bool {
        let fetchRequest = NSFetchRequest<Message>(entityName: "Message")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        
        var results: [NSManagedObject] = []
        
        do {
            results = try context!.fetch(fetchRequest)
        } catch {
            print("error executing fetch request: \(error)")
        }
        return results.count > 0
    }
    
    func clear(){
        let messageFetcheRequest = NSFetchRequest<Message>(entityName: "Message")
        let profilesFetcheRequest = NSFetchRequest<Profile>(entityName: "Profile")
        
        var messages: [NSManagedObject] = []
        var profiles: [NSManagedObject] = []
        
        do {
            messages = try context!.fetch(messageFetcheRequest)
            profiles = try context!.fetch(profilesFetcheRequest)
            
            for profile in profiles {
                context?.delete(profile)
            }
            for message in messages {
                context?.delete(message)
            }
        } catch {
            print("error executing fetch request: \(error)")
        }
    }
}






















