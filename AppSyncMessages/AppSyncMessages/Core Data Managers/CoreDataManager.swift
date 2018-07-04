//
//  CoreDataManager.swift
//  AppSyncMessages
//
//  Created by Rubens Neto on 04/07/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    
    lazy var context: NSManagedObjectContext? = {
        if let appDel = UIApplication.shared.delegate as? AppDelegate {
            return appDel.persistentContainer.viewContext
        }
        return nil
    }()
    
    func saveContext(){
        do {
            try context?.save()
        } catch let error {
            print(error)
        }
    }
}
