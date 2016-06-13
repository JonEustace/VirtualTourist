//
//  Pin.swift
//  VirtualTourist2
//
//  Created by iMac on 2016-05-20.
//  Copyright © 2016 iMac. All rights reserved.
//

import Foundation
import CoreData


class Pin: NSManagedObject {

    let entityName = "Pin"
   

    convenience init(latitude: Double, longitude: Double, context: NSManagedObjectContext){
        if let ent = NSEntityDescription.entityForName("Pin", inManagedObjectContext: context){
            self.init(entity: ent, insertIntoManagedObjectContext: context)
            self.latitude = latitude
            self.longitude = longitude
        } else {
            fatalError("Unable to find the " + "Pin" + " entity.")
        }
    }
    
   
    
}
