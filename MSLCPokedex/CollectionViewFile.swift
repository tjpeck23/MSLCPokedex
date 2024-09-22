//
//  CollectionViewFile.swift
//  MSLCPokedex
//
//  Created by Cady Studdard on 9/21/24.
//

import UIKit

class CollectionViewFile : UICollectionViewController{
    
    //new dic to get sprites from the viewcontroller class
    var pokemonSprites: NSMutableDictionary = [:]
    
    override func viewDidLoad() {
            super.viewDidLoad()
        }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            // Return the number of items in the collection
        //use this to show all the pokeman that were an option
            return 20 // Example: hardcoded number of items
        }
    
    
    
}
