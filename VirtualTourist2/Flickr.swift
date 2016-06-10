//
//  Flickr.swift
//  VirtualTourist
//
//  Created by iMac on 2016-04-26.
//  Copyright © 2016 iMac. All rights reserved.
//

import UIKit

class Flickr{
    
    
    func performGetRequest(parameters : [String : AnyObject], isBinary: Bool, completionHandler: (data : AnyObject!, error: NSError?) -> Void){
        
        
        let url = getRequest(parameters)
        
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        
        
        //start an ASYNC request
        let task = session.dataTaskWithRequest(request){ (data, response, error) in
            
            // if there is an error with the request, return it in the completion handler
            guard (error == nil) else {
                return completionHandler(data: data, error: error)
            }
            
            // check if there was an error with the response
            let responseErr = self.checkResponseForErrors(data, response: response, error: error)
            
            guard responseErr == nil else {
                return completionHandler(data: data, error: responseErr)
            }
            
            //No errors, so let's parse the JSON
            if !isBinary {
                let json = self.parseJSON(data)
                
                
                guard json.error == nil else {
                    
                    return completionHandler(data: data, error:json.error)
                }
                
                
                dispatch_async(dispatch_get_main_queue()) {
                    completionHandler(data: json.parsedJson , error: nil)
                }
                
            } else {
                completionHandler(data: data , error: nil)
            }
            
            
        }
        
        task.resume()
        
    }
    
    func getRequest(parameters : [String : AnyObject]) -> NSURL{
        
        let geoSearchRequest = NSMutableURLRequest(URL: Flickr.Consts.GEO_SEARCH_URL)
        geoSearchRequest.HTTPMethod = "GET"
        
        let components = NSURLComponents()
        
        components.scheme = "https"
        components.host = Flickr.Consts.HOST
        components.path = "/\(Flickr.Consts.PATH)/"
        
        //instanciate a query items array
        components.queryItems = [NSURLQueryItem]()
        
        //parse the query items and append to the URL components
        for (key, value) in parameters{
            let queryItem = NSURLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        print(components.URL)
        return components.URL!
        
    }
    
    func checkResponseForErrors(data : NSData?, response: NSURLResponse?, error : NSError?) -> NSError?{
        
        //check for error right off the bat
        guard error == nil else{
            return NSError(domain: "Error with request", code: 1, userInfo: [NSLocalizedDescriptionKey: "There was an error with the request: \(error)"])
        }
        
        //check to see if we got a valid response code
        guard let httpResponse = response as? NSHTTPURLResponse else {
            return NSError(domain: "Error with request", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid response: \(response)"])
        }
        
        guard httpResponse.statusCode == 200 else {
            return NSError(domain: "Error with request", code: 1, userInfo: [NSLocalizedDescriptionKey: "Recieved the following status code: \(httpResponse.statusCode)"])
        }
        
        //check to ensure that data was indeed returned
        
        guard let _ = data else{
            return NSError(domain: "Error with request", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data was returned"])
        }
        
        //no errors detected
        return nil
    }
    
    func parseJSON(data: NSData!) -> (parsedJson: [[String : AnyObject]]?, error: NSError?) {
        
        
        
        let parsedData : [String:AnyObject]!
        
        do{
            parsedData = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! [String : AnyObject]
            
        } catch {
            return (nil, NSError(domain: "Error occured", code: 1, userInfo: [NSLocalizedDescriptionKey : "Data wasn't parsed"]))
        }
        
        guard let photosDictionary = parsedData["photos"] as? [String:AnyObject] else{
            
            return (nil, NSError(domain: "Error occured", code: 1, userInfo: [NSLocalizedDescriptionKey : "Data wasn't parsed"]))
        }
        
        
        guard let photosArray = photosDictionary["photo"] as? [[String:AnyObject]] else {
            return (nil, NSError(domain: "Error occured", code: 1, userInfo: [NSLocalizedDescriptionKey : "Data wasn't parsed"]))
        }
        
        
        return (photosArray, nil)
    }
    
    func performPhotoDownload(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    
    func saveContext() {
        CoreDataStackManager.sharedInstance().saveContext()
    }
    
    lazy var sharedContext = {
        CoreDataStackManager.sharedInstance().managedObjectContext
    }()
    
}