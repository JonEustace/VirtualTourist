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
    /*
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }*/
    
    func addPhoto(value: Photo){
        let items = self.mutableSetValueForKey("photo")
        items.addObject(value)
    }
    
    func removePhoto(value: Photo){
       /* let items = self.mutableSetValueForKey("Photo")
        items.removeObject(value)*/
        
        
    }
    
    func removePhoto4(index: Int) -> NSSet{
        var items = photo?.allObjects as! [Photo]
        items.removeAtIndex(index)
        return NSSet(array: items)
    }
    
    func removePhoto2(value: Photo){
       // var mutableSet = NSMutableSet.setSet(self.photo)
    }
    
    func removePhoto3(){
        self.setValue(nil, forKey: "photo")
    }
    
    
    
    
    
    
}
