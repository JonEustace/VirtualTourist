//
//  MapPositionAndZoom.swift
//  VirtualTourist
//
//  Created by iMac on 2016-04-29.
//  Copyright © 2016 iMac. All rights reserved.
//

import Foundation
import MapKit


// This class uses NSUserDefaults to save the position of the map when a user moves it around.
class MapPositionAndZoom {
    
    var coordinateAndSpan : MKCoordinateRegion!
    var centerLat : Double?
    var centerLong : Double?
    var spanLat : Double?
    var spanLong : Double?
    
    
    func saveState(){
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setDouble(centerLat!, forKey: "centerLat")
        defaults.setDouble(centerLong!, forKey: "centerLong")
        defaults.setDouble(spanLat!, forKey: "spanLat")
        defaults.setDouble(spanLong!, forKey: "spanLong")
        
        
    }
    
    func loadState(){
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        centerLat = defaults.doubleForKey("centerLat")
        centerLong = defaults.doubleForKey("centerLong")
        spanLat = defaults.doubleForKey("spanLat")
        spanLong = defaults.doubleForKey("spanLong")
    }
    
}
