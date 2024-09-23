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
            //debugging because it aint working 
            print("Number of sprites: \(pokemonSprites.count)")
                
            collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        
            if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.itemSize = CGSize(width: 100, height: 100) // Adjust size accordingly
            }
        }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of items in the collection
        //use this to get the number of pokemon sprits used
        return pokemonSprites.count
        }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Dequeue reusable cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        
        // Get the sprite URL for the current item
        let keys = pokemonSprites.allKeys
        if let spriteUrl = pokemonSprites[keys[indexPath.item]] as? String {
            
            // Check if the imageView exists in the cell, otherwise create it
            //this came from internet because I cried for a few hours when it wouldn't work because we had so many pokemon
            var imageView = cell.viewWithTag(100) as? UIImageView
            if imageView == nil {
                // Create an image view and add it to the cell's content view
                imageView = UIImageView(frame: cell.contentView.bounds)
                imageView?.tag = 100
                imageView?.contentMode = .scaleAspectFit  // Ensure the image scales nicely
                cell.contentView.addSubview(imageView!)
            }
            
            // Update the image asynchronously
            if let imageView = imageView {
                updateImageView(imageView, with: spriteUrl)
            }
        }
        
        return cell
    }
    func updateImageView(_ imageView: UIImageView, with urlString: String) {
            guard let url = URL(string: urlString) else { return }

            //get the image data
            Task {
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            imageView.image = image
                        }
                    }
                } catch {
                    print("Failed to load image: \(error)")
                }
            }
        }
    
    
    
}
