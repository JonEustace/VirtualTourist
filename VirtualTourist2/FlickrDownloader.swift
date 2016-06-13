//
//  FlickrDownloader.swift
//  VirtualTourist2
//
//  Created by iMac on 2016-06-06.
//  Copyright © 2016 iMac. All rights reserved.
//

import Foundation
import CoreData

extension Flickr{
    
    
    
    // This function downloads urls to be assosiated with a pin. The results are randomly generated and limited
    // by the amount of urls to be downloaded specified by other calling functions.
    func downloadRandomUrls(numberOfUrlsToDownload: Int, pin : Pin, completionHandler: (success : Bool, error: NSError?) -> Void){
        
        
        if let latitude = pin.latitude, longitude = pin.longitude{
            
            let query : [String : AnyObject] = ["method": Flickr.Consts.GEO_METHOD, "format" : Flickr.Consts.FORMAT, "api_key": Flickr.Consts.API_KEY, "lat" : latitude, "lon" : longitude , "nojsoncallback" : "1", "per_page" : "100", "extras" : "url_m"]
            
            performGetRequest(query, isBinary: false, completionHandler: { (data, error) in
                let dataArray = data as! NSArray
                var queryResultArray = [String]()
                
                for url in dataArray{
                    if let url = url["url_m"]{
                        if let url = url{
                            queryResultArray.append(url as! String)
                        }
                    }
                }
                
                var photos = [Photo]()
                
                if queryResultArray.count == 0 {
                    print("no images")
                }
                
                while(photos.count <= numberOfUrlsToDownload && photos.count < queryResultArray.count){
                    let randomIndex = Int(arc4random_uniform(UInt32(queryResultArray.count)))
                    photos.append(Photo(url: queryResultArray[randomIndex], binary: NSData(), context: self.sharedContext))
                }
                
                pin.photo = NSSet().setByAddingObjectsFromArray(photos)
                
                self.downloadPhotos(pin, completionHandler: { (success, error) in
                    
                    if success{
                        completionHandler(success: true, error: nil)
                    } else {
                        print("error downloading photos: \(error)")
                        completionHandler(success: false, error: error)
                    }
                })
            })
        }
    }
    
    
    // This function downloads photos given an array of urls in which to fetch from. It then saves the images to a pin and
    // send a NSnotification that a download has completed.
    func downloadPhotos(pin: Pin, completionHandler: (success : Bool, error : NSError?) -> Void){
        
        
        
        // loop through all the url's in the pin and download the photos
        
        for photo in pin.photo!{
        
            let photo = photo as! Photo
            
            
            self.downloadPhoto(photo, completionHandler: { success, error in
                
                if success{
                    completionHandler(success: true, error: nil)
                  
                    self.saveContext()
                    dispatch_async(dispatch_get_main_queue()) {
                        NSNotificationCenter.defaultCenter().postNotificationName("downloadComplete", object: nil)
                    }
                } else {
                    print("there was an error: \(error)")
                    completionHandler(success: false, error: error)
                }
                
            })
        }
    }
    
    //NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadPhotos:", name: "downloadedComplete", object: nil)
    
    
    func downloadPhoto(photo: Photo, completionHandler: (success: Bool, error: NSError?) -> Void){
        
        performPhotoDownload(NSURL(string: photo.url!)!) { (data, response, error) in
            if let error = error {
                photo.url = "error"
                completionHandler(success: false, error: error)
            } else {
                
                if let data = data {
                    // assign the photo data to the photo
                    photo.binary = data
                    
                    completionHandler(success: true, error: nil)
                    
                } else {
                    photo.url = "error"
                    completionHandler(success: false, error: error)
                }
            }
        }
        
        
    }
    
    
}
