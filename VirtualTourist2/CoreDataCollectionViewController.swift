//
//  CoreDataCollectionViewController.swift
//  VirtualTourist2
//
//  Created by iMac on 2016-05-30.
//  Copyright © 2016 iMac. All rights reserved.
//

import UIKit
import CoreData

class CoreDataCollectionViewController : UICollectionViewController {
/*
    var blockOperations: [NSBlockOperation] = []
    
    var fetchedResultsController : NSFetchedResultsController?{
        didSet{
          
           fetchedResultsController?.delegate = self
            executeSearch()
            collectionView?.reloadData()
            
        }
    }
    
    init(fetchedResultsController fc : NSFetchedResultsController){
        fetchedResultsController = fc
        super.init(collectionViewLayout: CustomImageFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
    }
}

// MARK:  - View Lifecycle
extension CoreDataCollectionViewController{
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if let fc = fetchedResultsController{
        // Add a default title if you forgot it
        if title == nil{
            title = fc.fetchRequest.entity?.name
        }
        }
        
    }
}

// MARK:  - Subclass responsability
extension CoreDataCollectionViewController{
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        fatalError("This method MUST be implemented by a subclass of CoreDataTableViewController")
    }
    
}


//MARK: - Collection Data Source
extension CoreDataCollectionViewController{
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let fc = fetchedResultsController{
            return (fc.sections?.count)!
        } else {
            return 0
        }
        
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
}



// MARK:  - Fetches
extension CoreDataCollectionViewController{
    
    func executeSearch(){
        
        if let fc = fetchedResultsController{
        
            do{
                try fc.performFetch()
            }catch let e as NSError{
                print("Error while trying to perform a search: \n\(e)\n\(fetchedResultsController)")
            }
            
        }
    }
}


// MARK:  - Delegate



extension CoreDataCollectionViewController: NSFetchedResultsControllerDelegate{
    
   
    
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        
        
        collectionView!.performBatchUpdates({ () -> Void in
            for operation: NSBlockOperation in self.blockOperations {
                operation.start()
            }
            }, completion: { (finished) -> Void in
                self.blockOperations.removeAll(keepCapacity: false)
        })
    
    }
    
    
    
    
    func controller(controller: NSFetchedResultsController,
                    didChangeSection sectionInfo: NSFetchedResultsSectionInfo,
                                     atIndex sectionIndex: Int,
                                             forChangeType type: NSFetchedResultsChangeType) {
        
       
    }
    
    
    func controller(controller: NSFetchedResultsController,
                    didChangeObject anObject: AnyObject,
                                    atIndexPath indexPath: NSIndexPath?,
                                                forChangeType type: NSFetchedResultsChangeType,
                                                              newIndexPath: NSIndexPath?) {
        
        guard let newIndexPath = newIndexPath else{
            fatalError("No indexPath received")
        }
        switch(type){
            
        case .Insert:
            collectionView?.insertItemsAtIndexPaths([newIndexPath])
            
        case .Delete:
            collectionView?.deleteItemsAtIndexPaths([newIndexPath])
           
            
        case .Update:
            collectionView?.reloadItemsAtIndexPaths([newIndexPath])
            
            
        case .Move:
            collectionView?.deleteItemsAtIndexPaths([newIndexPath])
            collectionView?.insertItemsAtIndexPaths([newIndexPath])
        }
        
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        
        collectionView?.reloadData()
    }
 */
}

 