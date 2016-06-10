//
//  PhotosCollectionViewController.swift
//  VirtualTourist2
//
//  Created by iMac on 2016-05-30.
//  Copyright © 2016 iMac. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class PhotoAlbumViewController : UIViewController, NSFetchedResultsControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var pin: Pin!
    let flickr = Flickr()
    
    let viewLayout = CustomImageFlowLayout()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var newCollectionButton: UIButton!
    @IBOutlet weak var noImagesFoundLabel: UILabel!
    override func viewDidLoad() {
        // MARK: Map on load
        
        // show the pin of the location in question on the map
        
        let annotation = MKPointAnnotation()
        let coordinate = CLLocationCoordinate2D(latitude: Double(pin.latitude!), longitude: Double(pin.longitude!))
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        
        // show the correct region and location of the map
        let clLocation = CLLocationCoordinate2D(latitude: Double(pin.latitude!), longitude: Double(pin.longitude!))
        let span = MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)
        
        mapView.setRegion(MKCoordinateRegion(center: clLocation, span: span), animated: false)
        
        //disable scrolling
        mapView.scrollEnabled = false
        
       
        
        //MARK: Collection view on load
        // set the souce and delegate of the collection view
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView!.collectionViewLayout = CustomImageFlowLayout()
        
        // Fetch the results for the pin
        fetch()
        
        // Use the notifcation center to reload images when they have downloaded (subscriber pattern)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PhotoAlbumViewController.reloadPhotos(_:)), name: "downloadComplete", object: nil)
        
       
    }

    func fetch(){
        do{
            try self.fetchedResultsController.performFetch()
        } catch let error as NSError{
            print("there was an error \(error)")
        }
        
    }
    
    
    @IBAction func newCollectionButtonClicked(sender: AnyObject) {
      
        
        for photo in pin.photo!{
         
            sharedContext.deleteObject(photo as! NSManagedObject)
        }
        
        pin.photo = NSSet()
        
        saveContext()
        
        fetch()
        
        
        flickr.downloadRandomUrls(21, pin: self.pin) { (success, error) in
            

        
        }
        
      
        
        
        
        
       
        
    }
    
    //MARK: Collection view required methods

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //print("num items: \(self.fetchedResultsController.sections![section].numberOfObjects)")
        
        let numberOfObjects = self.fetchedResultsController.sections![section].numberOfObjects
        if numberOfObjects > 0 {
            self.noImagesFoundLabel.hidden = true
        } else {
            self.noImagesFoundLabel.hidden = false
        }
        return numberOfObjects
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        print("selected \(indexPath.row)")
        
        let photoz = fetchedResultsController.objectAtIndexPath(indexPath) as! Photo
        
        
        //let newSet = pin.removePhoto4(indexPath.row)
        
       //
        
       
    //  pin.photo = NSSet()
        
        CoreDataStackManager.sharedInstance().saveContext()
        
          fetch()
        self.collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
    
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as! PhotoAlbumCollectionViewCell
        
        let photo = fetchedResultsController.objectAtIndexPath(indexPath) as? Photo
        
        if let binary = photo?.binary{
              cell.imageView.image = UIImage(data: binary)
        }
        
        return cell
        
    }
    
    
    
    func reloadPhotos(notification: NSNotification){
        fetch()
        self.collectionView.reloadData()
    }
    
    
    // lazily instanciated FRC sorted by the photo_path.
    lazy var fetchedResultsController : NSFetchedResultsController = {
        // Prepare for a fetch request on the Photo entity
        let fetchRequest = NSFetchRequest(entityName: "Photo")
        // Only grab the photos that are in relation to the pin loaded in the view
        fetchRequest.predicate = NSPredicate(format: "pin == %@", self.pin)
        
        // Sort the request based on the url (a sort is mandatory, yet this sort is arbitrary)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "url", ascending: true)]
        
        // createa fetch controller given the settings above.
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.sharedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultsController
    }()
    
    // grab a handle to the managed object context singleton
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    
    func saveContext() {
        CoreDataStackManager.sharedInstance().saveContext()
    }

}

