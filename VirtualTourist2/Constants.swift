//
//  Constants.swift
//  VirtualTourist
//
//  Created by iMac on 2016-04-27.
//  Copyright © 2016 iMac. All rights reserved.
//

import Foundation

extension Flickr{

    struct Consts{
        static let SCHEME = "https"
        static let HOST = "api.flickr.com"
        static let PATH = "services/rest"
        static let GEO_METHOD = "flickr.photos.search"
        static let API_KEY = "864e26369bcb798c89db11520c4cc28c"
        static let FORMAT = "json"
        static let JSONCALLBACK = "1"
        
         static let GEO_SEARCH_URL = NSURL(fileURLWithPath: "https://api.flickr.com/services/rest/")
    }
}
