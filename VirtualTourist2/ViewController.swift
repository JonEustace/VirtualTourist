//
//  ViewController.swift
//  VirtualTourist2
//
//  Created by iMac on 2016-05-19.
//  Copyright © 2016 iMac. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class ViewController: UIViewController, UIGestureRecognizerDelegate, MKMapViewDelegate {
    
    //keep track of current position and zoom of map
    let mapPosition = MapPositionAndZoom()
    
    var pin : Pin?
    var pinArr : [Pin]?
    let flickr = Flickr()
    
    @IBOutlet weak var mapView: MKMapView!
    
    lazy var sharedContext = {
        CoreDataStackManager.sharedInstance().managedObjectContext
    }()
    
    func saveContext() {
        CoreDataStackManager.sharedInstance().saveContext()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add gesture recognizer to the mapview.
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: "didLongPressMap:")
        gestureRecognizer.delegate = self
        mapView.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
        
        // return the map the state it was at when the app was closed.
        mapPosition.loadState()
        let clLocation = CLLocationCoordinate2D(latitude: mapPosition.centerLat!, longitude: mapPosition.centerLong!)
        let span = MKCoordinateSpan(latitudeDelta: mapPosition.spanLat!, longitudeDelta: mapPosition.spanLong!)
        
        mapView.setRegion(MKCoordinateRegion(center: clLocation, span: span), animated: false)
        
        
        //load all the saved pins onto the map
        pinArr = fetchAllPins()
        
        
        for pin in pinArr!{
            
            
            let annotation = MKPointAnnotation()
            let coordinate = CLLocationCoordinate2D(latitude: Double(pin.latitude!), longitude: Double(pin.longitude!))
            annotation.coordinate = coordinate
            
            mapView.addAnnotation(annotation)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This function fires when the map's display region changes.
    // it saves the state of the map
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let currentRegion = mapView.region
        mapPosition.centerLat =  currentRegion.center.latitude
        mapPosition.centerLong = currentRegion.center.longitude
        mapPosition.spanLat = currentRegion.span.latitudeDelta
        mapPosition.spanLong = currentRegion.span.longitudeDelta
        
        mapPosition.saveState()
    }
    
    
    // This function handles the gestures of a long press on the map
    // When a long press occurs it creates a pin and adds an annotation to the map
    func didLongPressMap(gestureRecognizer : UIGestureRecognizer){
        if(gestureRecognizer.state == UIGestureRecognizerState.Began){
            let touchedLocation = gestureRecognizer.locationInView(mapView);
            let coordinate = mapView.convertPoint(touchedLocation, toCoordinateFromView: mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            
            
            mapView.addAnnotation(annotation)
            
            pin = Pin(latitude: coordinate.latitude, longitude: coordinate.longitude, context: self.sharedContext)
            
            if let pin = pin {
                
                flickr.downloadRandomUrls(21, pin: pin, completionHandler: { (success, error) in
                    if success {
                      print("success!")
                    } else {
                        print("error \(error)")
                    }
                })
            }
          
        }
    }
    
    func fetchAllPins() -> [Pin] {
        let fetchRequest = NSFetchRequest(entityName: "Pin")
        do {
            return try sharedContext.executeFetchRequest(fetchRequest) as! [Pin]
        } catch let error as NSError {
            print("Error in fetchAllActors(): \(error)")
            return [Pin]()
        }
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        
        for pin in pinArr!{
            if pin.latitude == view.annotation?.coordinate.latitude && pin.longitude == view.annotation?.coordinate.longitude{
                self.pin = pin
            }
        }
        
        //deselect the annotation so when you revisit this view you can select the same annotation again.
        mapView.deselectAnnotation(view.annotation, animated: false)
        
        performSegueWithIdentifier("ViewPinSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ViewPinSegue"{
            let vc = segue.destinationViewController as! PhotoAlbumViewController
            vc.pin = pin
            
        }
    }
}

