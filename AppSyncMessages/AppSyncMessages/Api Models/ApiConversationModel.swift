//
//  ApiConversationModel.swift
//  AppSyncMessages
//
//  Created by Rubens Neto on 26/06/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import Foundation

class ApiConversationModel {
    var id: String!
    var messageIds: [String]?
    
    convenience init(senderId: Int, receiverId: Int, messageId: String?){
        self.init()
        id = String(senderId) + String(receiverId)
        if let id = messageId {
            messageIds = [String]()
            messageIds?.append(id)
        }
    }
}
