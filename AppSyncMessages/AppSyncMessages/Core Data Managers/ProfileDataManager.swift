//
//  ProfileDataManager.swift
//  AppSyncMessages
//
//  Created by Rubens Neto on 04/07/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import UIKit
import CoreData

class ProfileDataManager: CoreDataManager {
    
    static let shared: ProfileDataManager = {
        return ProfileDataManager()
    }()
    
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
}
