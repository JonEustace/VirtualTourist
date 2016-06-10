//
//  PhotoAlbumController.swift
//  VirtualTourist2
//
//  Created by iMac on 2016-06-02.
//  Copyright © 2016 iMac. All rights reserved.
//

import UIKit
import CoreData

class PhotoAlbumController : CoreDataCollectionViewController {

    override func viewDidLoad() {
        collectionView!.backgroundColor = UIColor.blueColor()
        collectionView!.collectionViewLayout = CustomImageFlowLayout()
    }
    
    
}
