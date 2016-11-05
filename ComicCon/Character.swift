//
//  Character.swift
//  ComicCon
//
//  Created by susan lovaglio on 10/30/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit

class Character{
    
    let store = DataStore.sharedInstance
    
    let name: String
    let image: UIImage?
    let imageAddress: String?
    
    init(name:String, image: UIImage?, imageAddress: String?) {
        
        self.name =  name
        self.image = image
        self.imageAddress = imageAddress
    }
    
    func convertToSaved() {
        
        let savedCharacter = SavedCharacter(context: store.persistentContainer.viewContext)
        
        savedCharacter.name = self.name
        savedCharacter.imageAddress = self.imageAddress
    }
    
}
