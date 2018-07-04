//
//  ConversationsDataSource.swift
//  AppSyncMessages
//
//  Created by Rubens Neto on 26/06/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import UIKit
import CoreData

class ConversationsDataSource {
    var messages: [Message]? = [Message]()
    
    init(){
        
        clearDataFromLocalStorage()
        
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDel.persistentContainer.viewContext
        let profileEntity = NSEntityDescription.entity(forEntityName: "Profile", in: context)!
        
        let luiz = NSManagedObject(entity: profileEntity, insertInto: context) as! Profile
        luiz.id = 11111
        luiz.name = "Luiz Mota"
        var image = UIImage(named: "LoginBackground1")!
        luiz.profileImage = UIImageJPEGRepresentation(image, 0.7)!
        luiz.isOnline = true
        
        ConversationsDataSource.createMessage(text: "We should be doing Unit Tests...", profile: luiz, date: Date(), context: context, isSender: false)
        
        let chris = NSManagedObject(entity: profileEntity, insertInto: context) as! Profile
        chris.id = 22222
        chris.name = "Chris Schumann"
        image = UIImage(named: "LoginBackground2")!
        chris.profileImage = UIImageJPEGRepresentation(image, 0.7)
        chris.isOnline = false
        
        ConversationsDataSource.createMessage(text: "I can't, I have kids!!!", profile: chris, date: Date(timeInterval: -60, since: Date()), context: context, isSender: false)
        
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        let brett = NSManagedObject(entity: profileEntity, insertInto: context) as! Profile
        brett.id = 33333
        brett.name = "Brett Schumann"
        image = UIImage(named: "LoginBackground3")!
        brett.profileImage = UIImageJPEGRepresentation(image, 0.7)
        brett.isOnline = false
        
        ConversationsDataSource.createMessage(text: "Living is winning!", profile: brett, date: Date(timeInterval: -120, since: Date()), context: context, isSender: false)

        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        let rubens = NSManagedObject(entity: profileEntity, insertInto: context) as! Profile
        rubens.id = 44444
        rubens.name = "Rubens Neto"
        image = UIImage(named: "LoginBackground4")!
        rubens.profileImage = UIImageJPEGRepresentation(image, 0.7)
        rubens.isOnline = false
        
        ConversationsDataSource.createMessage(text: "Pub?", profile: rubens, date: Date(timeInterval: -180, since: Date()), context: context, isSender: false)
        
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        let tibo = NSManagedObject(entity: profileEntity, insertInto: context) as! Profile
        tibo.id = 55555
        tibo.name = "TiBo"
        image = UIImage(named: "LoginBackground5")!
        tibo.profileImage = UIImageJPEGRepresentation(image, 0.7)
        tibo.isOnline = true
        
        ConversationsDataSource.createMessage(text: "Do you have any pain killers?", profile: tibo, date: Date(timeInterval: -240, since: Date()), context: context, isSender: false)
        ConversationsDataSource.createMessage(text: "Hey TiBo! Don't worry man, everything is gonna be alright, how can I help you?", profile: tibo, date: Date(timeInterval: -270, since: Date()), context: context, isSender: true)
        ConversationsDataSource.createMessage(text: "I'm totally in pain for more than a month now and this fucking sucks!!! I'm not kidding, I'm gonna kill someone.", profile: tibo, date: Date(timeInterval: -300, since: Date()), context: context, isSender: false)
        
        do {
            try context.save()
        } catch let error {
            print(error)
        }
        
        loadDataFromLocalStorage()
    }
    
    static func createMessage(text: String, profile: Profile, date: Date, context: NSManagedObjectContext, isSender: Bool) {
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.text = text
        message.timestamp = date
        message.isSender = isSender
        message.profile = profile
        
        let userId = UserDefaults.standard.value(forKey: "userId") as! Int
        isSender ?
            (message.id = String(describing: userId) + String(describing: profile.id) + String(describing: message.timestamp)) :
            (message.id = String(describing: profile.id) + String(describing: userId) + String(describing: message.timestamp))
    }
    
    func loadDataFromLocalStorage(){
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDel.persistentContainer.viewContext
        
        if let profiles = fetchProfiles() {
            for profile in profiles {
                let fetchRequest = NSFetchRequest<Message>(entityName: "Message")
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
                fetchRequest.predicate = NSPredicate(format: "profile.id = %ld", profile.id)
                fetchRequest.fetchLimit = 1
                do {
                    let fetchedMessages = try context.fetch(fetchRequest)
                    messages?.append(contentsOf: fetchedMessages)
                } catch let error {
                    print(error)
                }
            }
        }
        messages = messages?.sorted(by:{ $0.timestamp! > $1.timestamp!})
    }
    
    func fetchProfiles() -> [Profile]? {
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let context = appDel.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Profile>(entityName: "Profile")
        do {
            let profiles = try context.fetch(fetchRequest)
            return profiles
        } catch let error {
            print(error)
        }
        return nil
    }
    
    func clearDataFromLocalStorage(){
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDel.persistentContainer.viewContext
        let messagesFetchRequest = NSFetchRequest<Message>(entityName: "Message")
        let profilesFetchRequest = NSFetchRequest<Profile>(entityName: "Profile")
        do {
            let messages = try context.fetch(messagesFetchRequest)
            for message in messages {
                context.delete(message)
            }
            let profiles = try context.fetch(profilesFetchRequest)
            for profile in profiles {
                context.delete(profile)
            }
            try context.save()
        } catch let error {
            print(error)
        }
    }
}






















