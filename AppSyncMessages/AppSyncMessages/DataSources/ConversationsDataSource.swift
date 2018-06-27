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
        let messageEntity = NSEntityDescription.entity(forEntityName: "Message", in: context)!
        let profileEntity = NSEntityDescription.entity(forEntityName: "Profile", in: context)!
        
        let luiz = NSManagedObject(entity: profileEntity, insertInto: context) as! Profile
        luiz.id = 11111
        luiz.name = "Luiz Mota"
        var image = UIImage(named: "LoginBackground1")!
        luiz.profileImage = UIImageJPEGRepresentation(image, 0.7)!
        luiz.isOnline = true
        
        let luizMessage = NSManagedObject(entity: messageEntity, insertInto: context) as! Message
        luizMessage.id = 11111
        luizMessage.text = "We should be doing Unit Tests..."
        luizMessage.profile = luiz
        luizMessage.timestamp = Date()
        
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        let chris = NSManagedObject(entity: profileEntity, insertInto: context) as! Profile
        chris.id = 22222
        chris.name = "Chris Schumann"
        image = UIImage(named: "LoginBackground2")!
        chris.profileImage = UIImageJPEGRepresentation(image, 0.7)
        chris.isOnline = false
        
        let chrisMessage = NSManagedObject(entity: messageEntity, insertInto: context) as! Message
        chrisMessage.id = 22222
        chrisMessage.text = "I can't, I have kids!!!"
        chrisMessage.profile = chris
        chrisMessage.timestamp = Date(timeInterval: -60, since: Date())
        
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        let brett = NSManagedObject(entity: profileEntity, insertInto: context) as! Profile
        brett.id = 33333
        brett.name = "Brett Schumann"
        image = UIImage(named: "LoginBackground3")!
        brett.profileImage = UIImageJPEGRepresentation(image, 0.7)
        brett.isOnline = false
        
        let brettMessage = NSManagedObject(entity: messageEntity, insertInto: context) as! Message
        brettMessage.id = 33333
        brettMessage.text = "Living is winning!"
        brettMessage.profile = brett
        brettMessage.timestamp = Date(timeInterval: -120, since: Date())
        
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        let rubens = NSManagedObject(entity: profileEntity, insertInto: context) as! Profile
        rubens.id = 44444
        rubens.name = "Rubens Neto"
        image = UIImage(named: "LoginBackground4")!
        rubens.profileImage = UIImageJPEGRepresentation(image, 0.7)
        rubens.isOnline = false
        
        let rubensMessage = NSManagedObject(entity: messageEntity, insertInto: context) as! Message
        rubensMessage.id = 44444
        rubensMessage.text = "Pub?"
        rubensMessage.profile = rubens
        rubensMessage.timestamp = Date(timeInterval: -180, since: Date())
        
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        let tibo = NSManagedObject(entity: profileEntity, insertInto: context) as! Profile
        tibo.id = 55555
        tibo.name = "TiBo"
        image = UIImage(named: "LoginBackground5")!
        tibo.profileImage = UIImageJPEGRepresentation(image, 0.7)
        tibo.isOnline = true
        
        let tiboMessage = NSManagedObject(entity: messageEntity, insertInto: context) as! Message
        tiboMessage.id = 55555
        tiboMessage.text = "Do you have any pain killers?"
        tiboMessage.profile = tibo
        tiboMessage.timestamp = Date(timeInterval: -240, since: Date())
        
        
        let tiboMessage2 = NSManagedObject(entity: messageEntity, insertInto: context) as! Message
        tiboMessage2.id = 66666
        tiboMessage2.text = "Material Design sucks!!!"
        tiboMessage2.profile = tibo
        tiboMessage2.timestamp = Date(timeInterval: -300, since: Date())
        
        do {
            try context.save()
        } catch let error {
            print(error)
        }
        
        loadDataFromLocalStorage()
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






















