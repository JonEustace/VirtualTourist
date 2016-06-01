//
//  CustomeImageFlowLayouut.swift
//  VirtualTourist2
//
//  Created by iMac on 2016-05-25.
//  Copyright © 2016 iMac. All rights reserved.
//

import UIKit

class CustomImageFlowLayout : UICollectionViewFlowLayout{
    
    override init(){
        super.init()
       // setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        //setupLayout()
    }
    
    func setupLayout(){
        self.minimumInteritemSpacing = 15
        self.minimumLineSpacing = 15
        scrollDirection = .Vertical
        
        
    }
    
    override var itemSize: CGSize{
        set{
        }
        
        get{
            let numberOfColumns: CGFloat = 3
            
            // 200 - 2 / 3
            
            let itemWidth = (CGRectGetWidth(self.collectionView!.frame) - (self.minimumInteritemSpacing * numberOfColumns - 1)) / numberOfColumns
            return CGSizeMake(itemWidth, itemWidth)
        }
    }
}
