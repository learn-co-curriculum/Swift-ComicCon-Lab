//
//  DataStore.swift
//  ComicCon
//
//  Created by susan lovaglio on 10/30/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataStore{
    
    static let sharedInstance = DataStore()
    var characters = [Character]()
    var savedCharacters = [SavedCharacter]()
    
    func getCharacters(with completion: @escaping (Bool) -> ()){
        
        ComicVineAPIClient.getCharactersFromAPI { (dictionaries) in
            
            for each in dictionaries{
                
                guard let name = each["name"] as? String else{break}
                
                if let unwrappedImages = each["image"] as? [String: Any]{
                    if let iconImage = unwrappedImages["icon_url"] as? String{
                        if let iconUrl = URL(string: iconImage){
                            
                            do{
                                let imagedata = try Data(contentsOf: iconUrl)
                                let image = UIImage(data: imagedata)
                                
                                let character = Character(name: name, image: image, imageAddress: iconImage)
                                self.characters.append(character)
                                
                            }catch{
                                let character = Character(name: name, image: nil, imageAddress: nil)
                                
                                self.characters.append(character)
                                print("image download error:\(error.localizedDescription)")
                                
                            }
                        }
                    }
                }
            }
            completion(true)
            
        }
    }
    
    func getSavedCharacters(){
        do{
            
            let chars = try self.context.fetch(SavedCharacter.fetch)
            savedCharacters = chars
//            print(savedCharacters)
        }catch{
            print("fetch gone wrong:\(error.localizedDescription)")
        }
    }
    // MARK: - Core Data stack
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "ComicCon")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    //
    //    func fetchData(){
    //       let optionalFetch = try? SavedCharacter.fetch().execute()
    //        if let fetch = optionalFetch{
    ////            characters = fetch
    //        }
    //    }
    
}
