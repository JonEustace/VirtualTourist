//
//  PinViewController.swift
//  VirtualTourist2
//
//  Created by iMac on 2016-05-20.
//  Copyright © 2016 iMac. All rights reserved.
//

import UIKit
import MapKit

class PinViewController : CoreDataCollectionViewController  {

    
    @IBOutlet weak var mapView: MKMapView!
    var pin:Pin!
    var photoArr:[Photo]?
    let flickr = Flickr()

    let imgOne = UIImage(named: "1")
    let imgTwo = UIImage(named: "2")
    
    let viewLayout = UICollectionViewFlowLayout()
   
    
    
    let arrz = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "1"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "1"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "1"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "1"), UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "2")]
    
 
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
      
       // collectionView!.backgroundColor = UIColor.blueColor()
       //collectionView!.collectionViewLayout = CustomImageFlowLayout()
       
        resolvePhotos()
        
        
    }
    
    func resolvePhotos(){
        if let latitude = pin.latitude , longitude = pin.longitude{
            
            if pin.photo?.count == 0 {
                
                photoArr = pin.photo?.allObjects as? [Photo]
                //var i = photoArr![0].photo_path
                
                print(photoArr!.count)
                
                let parameters : [String : AnyObject] = ["method": Flickr.Consts.GEO_METHOD, "format" : Flickr.Consts.FORMAT, "api_key": Flickr.Consts.API_KEY, "lat" : latitude, "lon" : longitude, "nojsoncallback" : "1", "per_page" : "21", "extras" : "url_m"]
                
                flickr.performGetRequest(parameters) { (data, error) in
                    
                  print(data.count)
                    
                    for record in data as! [AnyObject]{
                        
                         print((record["url_m"] as? String)!)
                      
                        let p =  Photo(photo_path: (record["url_m"] as? String)!, photo_url: (record["url_m"] as? String)!, photo_bin: NSData(), context: self.sharedContext)
                        
                        /*let p = Photo(photo_path: (record["url_m"] as? String)!, photo_url: (record["url_m"] as? String)! context: self.sharedContext)*/
                        self.pin.addPhotoURL(p)
                        }
                    
                 
                      self.saveContext()
                }
                
            } else {
                print("photos")
            }

        
        
        }
    }
    
    
    /*
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
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as! PhotoAlbumCollectionViewCell
        cell.imageView.image = arrz[indexPath.row]
        cell.backgroundColor = UIColor.blueColor()
        cell.activityIndicator.startAnimating()
        
        print("fdf")
        
        if let photoArr = photoArr{
             print(photoArr[indexPath.row])
        }
        print("fdf")
       
        
        
        return cell
    }*/
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
       
        
        let pic = fetchedResultsController!.objectAtIndexPath(indexPath) as! Photo
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as! PhotoAlbumCollectionViewCell
        
        if let pic = pic.photo_bin{
            
            let image = UIImage(data:pic)
            
            cell.imageView.image = image
        } else {
            print("download image")
        }
        return cell
        
        
    }
    
    func saveContext() {
        CoreDataStackManager.sharedInstance().saveContext()
    }
    
    lazy var sharedContext = {
        CoreDataStackManager.sharedInstance().managedObjectContext
    }()

    
}
