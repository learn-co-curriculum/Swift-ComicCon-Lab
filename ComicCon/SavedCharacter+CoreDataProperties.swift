//
//  SavedCharacter+CoreDataProperties.swift
//  ComicCon
//
//  Created by Flatiron School on 11/4/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreData


extension SavedCharacter {
 
    class var fetch: NSFetchRequest<SavedCharacter> {
        
        return NSFetchRequest<SavedCharacter>(entityName: "SavedCharacter")
    }

    @NSManaged public var name: String?
    @NSManaged public var imageAddress: String?

}
