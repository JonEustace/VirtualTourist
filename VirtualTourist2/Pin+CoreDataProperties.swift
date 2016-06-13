//
//  Pin+CoreDataProperties.swift
//  VirtualTourist2
//
//  Created by iMac on 2016-05-20.
//  Copyright © 2016 iMac. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Pin {

    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var photo: NSSet?

}


