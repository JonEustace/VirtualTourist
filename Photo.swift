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
    
    convenience init(url : String, binary: NSData, context: NSManagedObjectContext){
        if let ent = NSEntityDescription.entityForName("Photo", inManagedObjectContext: context){
            self.init(entity: ent, insertIntoManagedObjectContext: context)
            self.url = url
            self.binary = binary
        } else {
            fatalError("Unable to find the " + "Photo" + " entity.")
        }
    }
   
    
    
}
