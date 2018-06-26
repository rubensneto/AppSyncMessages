//
//  ConversationsDataSource.swift
//  AppSyncMessages
//
//  Created by Rubens Neto on 26/06/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import UIKit

class ConversationsDataSource {
    var messages = [ApiMessage]()
    
    init(){
        
        let luiz = Profile()
        luiz.id = 11111
        luiz.name = "Luiz Mota"
        luiz.profileImage = UIImage(named: "LoginBackground1")
        luiz.isOnline = true
        
        let luizMessage = ApiMessage()
        luizMessage.id = 11111
        luizMessage.text = "We should be doing Unit Tests..."
        luizMessage.sender = luiz
        luizMessage.timestamp = Date()
        
        messages.append(luizMessage)
        
        let chris = Profile()
        chris.id = 22222
        chris.name = "Chris Schumann"
        chris.profileImage = UIImage(named: "LoginBackground2")
        
        let chrisMessage = ApiMessage()
        chrisMessage.id = 22222
        chrisMessage.text = "I can't, I have kids!!!"
        chrisMessage.sender = chris
        chrisMessage.timestamp = Date(timeInterval: -60, since: Date())
        
        messages.append(chrisMessage)
        
        let brett = Profile()
        brett.id = 33333
        brett.name = "Brett Schumann"
        brett.profileImage = UIImage(named: "LoginBackground3")
        
        let brettMessage = ApiMessage()
        brettMessage.id = 33333
        brettMessage.text = "Living is winning!"
        brettMessage.sender = brett
        brettMessage.timestamp = Date(timeInterval: -120, since: Date())
        
        messages.append(brettMessage)
        
        let rubens = Profile()
        rubens.id = 44444
        rubens.name = "Rubens Neto"
        rubens.profileImage = UIImage(named: "LoginBackground4")
        
        let rubensMessage = ApiMessage()
        rubensMessage.id = 44444
        rubensMessage.text = "Pub?"
        rubensMessage.sender = rubens
        rubensMessage.timestamp = Date(timeInterval: -180, since: Date())
        
        messages.append(rubensMessage)
        
        let tibo = Profile()
        tibo.id = 55555
        tibo.name = "TiBo"
        tibo.profileImage = UIImage(named: "LoginBackground5")
        tibo.isOnline = true
        
        let tiboMessage = ApiMessage()
        tiboMessage.id = 55555
        tiboMessage.text = "Do you have any pain killers?"
        tiboMessage.sender = tibo
        tiboMessage.timestamp = Date(timeInterval: -240, since: Date())
        
        messages.append(tiboMessage)
        
        let mat = Profile()
        mat.id = 66666
        mat.name = "Matt"
        mat.profileImage = UIImage(named: "LoginBackground6")
        
        let matMessage = ApiMessage()
        matMessage.id = 66666
        matMessage.text = "Material Design sucks!!!"
        matMessage.sender = mat
        matMessage.timestamp = Date(timeInterval: -300, since: Date())
        
        messages.append(matMessage)
    }
}
