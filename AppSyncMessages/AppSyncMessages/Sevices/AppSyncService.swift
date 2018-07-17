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
    
    func createConversationOnAppSync(senderId: Int, receiverId: Int, messageId: String){
        let conversation = ApiConversationModel(senderId: senderId, receiverId: receiverId, messageId: messageId)
        let mutationInput = CreateConversationInput(id: conversation.id, messageIds: [messageId])
        let mutation = CreateConversationMutation(input: mutationInput)
        
        appSyncClient.perform(mutation: mutation, optimisticUpdate: { (transaction) in
            do {
                try transaction?.update(query: AllConversationsQuery()) { (data: inout AllConversationsQuery.Data) in
                    data.listConversations?.items?.append(AllConversationsQuery.Data.ListConversation.Item.init(id: conversation.id, messageIds: [messageId]))
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
    
    func updateConversationOnAppSync(senderId: Int, receiverId: Int, messageId: String){
        let conversation = ApiConversationModel(senderId: senderId, receiverId: receiverId, messageId: messageId)
        let mutation = UpdateConversationMessagesMutation(id: conversation.id, messageId: conversation.messageIds!.last)
        
        appSyncClient.perform(mutation: mutation, optimisticUpdate: { (transaction) in
            do {
                try transaction?.update(query: AllConversationsQuery(), { (data: inout AllConversationsQuery.Data) in
                     data.listConversations?.items?.append(AllConversationsQuery.Data.ListConversation.Item.init(id: conversation.id, messageIds: [messageId]))
                })
//                try transaction?.update(query: AllConversationsQuery()) { (data: inout AllConversationsQuery.Data) in
//                    data.listConversations?.items?.append(AllConversationsQuery.Data.ListConversation.Item.init(id: conversation.id, messageIds: [messageId]))
//                }
            } catch let error {
                print(error.localizedDescription)
            }
        }) { (result, error) in
            if let error = error as? AWSAppSyncClientError {
                print("Error occurred: \(error.localizedDescription )")
                return
            }
        }
    }
    
    func subscribeToConversation(senderId: Int, receiverId: Int, messageId: String){
        let conversation = ApiConversationModel(senderId: senderId, receiverId: receiverId, messageId: messageId)
        let subscription = OnUpdateConversationSubscription()
        //appSyncClient.subscribe(subscription: <#T##GraphQLSubscription#>, resultHandler: <#T##(GraphQLResult<GraphQLSelectionSet>?, ApolloStore.ReadWriteTransaction?, Error?) -> Void#>)
    }
}













