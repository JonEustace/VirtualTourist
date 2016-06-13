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
class MapPositionAndZoom : NSObject, CLLocationManagerDelegate{
    
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
        
        
        // check to see if this is the first time running the app
        if defaults.objectForKey("centerLat") == nil {
            centerLat = 19.3339437868486
            centerLong = -94.0095821984674
            spanLat = 130.909353076688
            spanLong = 114.885586317066
        } else {
            centerLat = defaults.doubleForKey("centerLat")
            centerLong = defaults.doubleForKey("centerLong")
            spanLat = defaults.doubleForKey("spanLat")
            spanLong = defaults.doubleForKey("spanLong")
        }
    }
    
    @objc func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
}
