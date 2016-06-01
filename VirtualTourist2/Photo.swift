//
//  Photo.swift
//  VirtualTourist2
//
//  Created by iMac on 2016-05-20.
//  Copyright © 2016 iMac. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Photo: NSManagedObject {
    
    let entityName = "Photo"
    
    convenience init(photo_path: String, photo_url : String, context: NSManagedObjectContext){
        if let ent = NSEntityDescription.entityForName("Photo", inManagedObjectContext: context){
            self.init(entity: ent, insertIntoManagedObjectContext: context)
            self.photo_path = photo_path
            self.photo_url = photo_url
        } else {
            fatalError("Unable to find the " + "Photo" + " entity.")
        }
    }
    
  
}
