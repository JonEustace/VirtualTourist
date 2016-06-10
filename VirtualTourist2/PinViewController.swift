//
//  PinViewController.swift
//  VirtualTourist2
//
//  Created by iMac on 2016-05-20.
//  Copyright © 2016 iMac. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class PinViewController : UIViewController  {
/*
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var mapView: MKMapView!
    var pin:Pin!
    var photoArr:[Photo]?
    let flickr = Flickr()

    let imgOne = UIImage(named: "1")
    let imgTwo = UIImage(named: "2")
    
    let viewLayout = UICollectionViewFlowLayout()
   
    
    
    let arrz = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "1"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "1"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "1"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "1"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "2")]
    
 
    lazy var fetchedResultsController : NSFetchedResultsController = {
        let fetchRequest = NSFetchRequest(entityName: "Photo")
        
        fetchRequest.predicate = NSPredicate(format: "pin == %@", self.pin)
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "photo_path", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.sharedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController
    }()
    
     override func viewDidLoad() {
        
        // show the pin on the map
        let annotation = MKPointAnnotation()
        let coordinate = CLLocationCoordinate2D(latitude: Double(pin.latitude!), longitude: Double(pin.longitude!))
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        
        // show the correct region of the map
        let clLocation = CLLocationCoordinate2D(latitude: Double(pin.latitude!), longitude: Double(pin.longitude!))
        let span = MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)
        
        mapView.setRegion(MKCoordinateRegion(center: clLocation, span: span), animated: false)
        
        //disable scrolling
        mapView.scrollEnabled = false
      
        collectionView!.backgroundColor = UIColor.whiteColor()
        collectionView!.collectionViewLayout = CustomImageFlowLayout()
       
        do{
            try fetchedResultsController.performFetch()
          
            photoArr = fetchedResultsController.fetchedObjects as! [Photo]
            collectionView.reloadData()
            
        } catch {
            print("error")
        }
        
        resolvePhotos()
        
        
    }
    
    func resolvePhotos(){
        if let latitude = pin.latitude , longitude = pin.longitude{
            
            if pin.photo?.count == 0 {
                
                
                photoArr = pin.photo?.allObjects as? [Photo]
                //var i = photoArr![0].photo_path
                
              
                
                let parameters : [String : AnyObject] = ["method": Flickr.Consts.GEO_METHOD, "format" : Flickr.Consts.FORMAT, "api_key": Flickr.Consts.API_KEY, "lat" : latitude, "lon" : longitude, "nojsoncallback" : "1", "per_page" : "21", "extras" : "url_m"]
                
                flickr.performGetRequest(parameters) { (data, error) in
                    
             
                    
                    for record in data as! [AnyObject]{
                        
                        
                        
                      
                        let p =  Photo(photo_path: (record["url_m"] as? String)!, photo_url: (record["url_m"] as? String)!, photo_bin: NSData(), context: self.sharedContext)
                        
                        /*let p = Photo(photo_path: (record["url_m"] as? String)!, photo_url: (record["url_m"] as? String)! context: self.sharedContext)*/
                        self.pin.addPhoto(p)
                        }
                    
                 
                      self.saveContext()
                    
                    print("calling download photos")
                    print(self.pin.photo?.count)
                    self.flickr.downloadPhotos(self.pin, completionHandler: {
                        
                    })
                }
                
            } else {
                
              
            
            }

        
        
        }
    }
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let photos = pin.photo {
            return photos.count
        }
        
        return 0
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
 
  
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        
        let pic = photoArr![indexPath.row]
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as! PhotoAlbumCollectionViewCell
        
        cell.imageView.image = UIImage(data:pic.photo_bin!)
        
        return cell
        
        
    }
  
    func saveContext() {
        CoreDataStackManager.sharedInstance().saveContext()
    }
    
    lazy var sharedContext = {
        CoreDataStackManager.sharedInstance().managedObjectContext
    }()
*/
    
}
