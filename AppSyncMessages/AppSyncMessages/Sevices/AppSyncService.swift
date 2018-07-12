//
//  AppSyncService.swift
//  AppSyncMessages
//
//  Created by Rubens Neto on 12/07/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import Foundation
import UIKit
import AWSAppSync

class AppSyncService {
    let appDel = UIApplication.shared.delegate as! AppDelegate
    lazy var appSyncClient: AWSAppSyncClient = {
        return appDel.appSyncClient!
    }()
    
    func addMessageOnAppSync(id: String, text: String, timestamp: String) {
        let mutationInput = CreateMessageInput(id: id, text: text, timestamp: timestamp)
        let mutation = AddMessageMutation(input: mutationInput)
        
        appSyncClient.perform(mutation: mutation, optimisticUpdate: { (transaction) in
            do {
                try transaction?.update(query: AllMessagesQuery()) { (data: inout AllMessagesQuery.Data) in
                    data.listMessages?.items?.append(AllMessagesQuery.Data.ListMessage.Item.init(id: id, text: text, timestamp: timestamp))
                }
            } catch {
                print("Error updating AppSync Response")
            }
        }) { (result, error) in
            if let error = error as? AWSAppSyncClientError {
                print("Error occurred: \(error.localizedDescription )")
                return
            }
        }
    }
}
