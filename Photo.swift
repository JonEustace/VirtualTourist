//
//  Photo.swift
//  VirtualTourist2
//
//  Created by iMac on 2016-05-30.
//  Copyright © 2016 iMac. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Photo: NSManagedObject {
    
    let entityName = "Photo"
    
    convenience init(photo_path: String, photo_url : String, photo_bin: NSData, context: NSManagedObjectContext){
        if let ent = NSEntityDescription.entityForName("Photo", inManagedObjectContext: context){
            self.init(entity: ent, insertIntoManagedObjectContext: context)
            self.photo_path = photo_path
            self.photo_url = photo_url
            self.photo_bin = photo_bin
        } else {
            fatalError("Unable to find the " + "Photo" + " entity.")
        }
    }
    
    
}
