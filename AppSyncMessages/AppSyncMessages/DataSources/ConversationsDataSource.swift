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
    var messages = [NSManagedObject]()
    
    init(){
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
        
        messages.append(luizMessage)
        
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
        
        messages.append(chrisMessage)
        
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
        
        messages.append(brettMessage)
        
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
        
        messages.append(rubensMessage)
        
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
        
        messages.append(tiboMessage)
        
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        let mat = NSManagedObject(entity: profileEntity, insertInto: context) as! Profile
        mat.id = 66666
        mat.name = "Matt"
        image = UIImage(named: "LoginBackground6")!
        mat.profileImage = UIImageJPEGRepresentation(image, 0.7)
        mat.isOnline = false
        
        let matMessage = NSManagedObject(entity: messageEntity, insertInto: context) as! Message
        matMessage.id = 66666
        matMessage.text = "Material Design sucks!!!"
        matMessage.profile = mat
        matMessage.timestamp = Date(timeInterval: -300, since: Date())
        
        messages.append(matMessage)
    }
}
