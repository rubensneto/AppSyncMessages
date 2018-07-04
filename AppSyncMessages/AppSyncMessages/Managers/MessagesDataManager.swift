//
//  MessagesDataManager.swift
//  AppSyncMessages
//
//  Created by Rubens Neto on 26/06/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import UIKit
import CoreData

class MessagesDataManager {
    
    static let shared: MessagesDataManager = {
        return MessagesDataManager()
    }()
    
    private lazy var context: NSManagedObjectContext? = {
        if let appDel = UIApplication.shared.delegate as? AppDelegate {
            return appDel.persistentContainer.viewContext
        }
        return nil
    }()
    
    var messages: [Message]? = [Message]()
    
    init(){
        
        if let luiz = createProfile(name: "Luiz Mota", id: 11111, image: UIImage(named: "LoginBackground1")!, isOnline: true) {
        _ = createMessage(text: "We should be doing Unit Tests...", profile: luiz, date: Date(), isSender: false)
        }
        
        if let chris = createProfile(name: "Chris Schumann", id: 22222, image: UIImage(named: "LoginBackground2")!, isOnline: false) {
        _ = createMessage(text: "I can't, I have kids!!!", profile: chris, date: Date(timeInterval: -60, since: Date()), isSender: false)
        }
        
        if let brett = createProfile(name: "Brett Schumann", id: 33333, image: UIImage(named: "LoginBackground3")!, isOnline: false) {
        _ = createMessage(text: "Living is winning!", profile: brett, date: Date(timeInterval: -120, since: Date()), isSender: false)
        }
        
        if let rubens = createProfile(name: "Rubens Neto", id: 44444, image: UIImage(named: "LoginBackground4")!, isOnline: false) {
        _ = createMessage(text: "Pub?", profile: rubens, date: Date(timeInterval: -180, since: Date()), isSender: false)
        }
        
        if let tibo = createProfile(name: "TiBo", id: 55555, image: UIImage(named: "LoginBackground5")!, isOnline: true) {
        _ = createMessage(text: "Do you have any pain killers?", profile: tibo, date: Date(timeInterval: -240, since: Date()), isSender: false)
        _ = createMessage(text: "Hey TiBo! Don't worry man, everything is gonna be alright, how can I help you?", profile: tibo, date: Date(timeInterval: -270, since: Date()), isSender: true)
        _ = createMessage(text: "I'm totally in pain for more than a month now and this fucking sucks!!! I'm not kidding, I'm gonna kill someone.", profile: tibo, date: Date(timeInterval: -300, since: Date()), isSender: false)
        }
        
        loadDataFromLocalStorage()
    }
    
    //MARK: Context Methods
    
    private func saveContext(){
        do {
            try context?.save()
        } catch let error {
            print(error)
        }
    }
    
    //MARK: Entities Methods
    
    func createProfile(name: String, id: Int, image: UIImage, isOnline: Bool) -> Profile? {
        if !checkForExintingProfile(id: id){
            let profile = NSEntityDescription.insertNewObject(forEntityName: "Profile", into: context!) as! Profile
            profile.name = name
            profile.id = Int64(id)
            profile.profileImage = UIImageJPEGRepresentation(image, 0.7)
            profile.isOnline = isOnline
        
            saveContext()
            return profile
        }
        return nil
    }
    
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
           
            saveContext()
            return message
        }
        return nil
    }
    
    //MARK: Fetch Methods
    
    private func loadDataFromLocalStorage(){
        if let profiles = fetchProfiles() {
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
    
    func fetchProfiles() -> [Profile]? {
        let fetchRequest = NSFetchRequest<Profile>(entityName: "Profile")
        do {
            let profiles = try context?.fetch(fetchRequest)
            return profiles
        } catch let error {
            print(error)
        }
        return nil
    }
    
    private func checkForExintingProfile(id: Int) -> Bool {
        let fetchRequest = NSFetchRequest<Profile>(entityName: "Profile")
        fetchRequest.predicate = NSPredicate(format: "id = %ld", id)
        
        var results: [NSManagedObject] = []
        
        do {
            results = try context!.fetch(fetchRequest)
        } catch {
            print("error executing fetch request: \(error)")
        }
        return results.count > 0
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
}






















