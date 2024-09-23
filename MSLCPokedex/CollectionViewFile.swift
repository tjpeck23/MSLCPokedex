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
       
        }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of items in the collection
        //use this to get the number of pokemon sprits used
        return pokemonSprites.count
        }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
           
           // get the sprite
           let keys = pokemonSprites.allKeys
           if let spriteUrl = pokemonSprites[keys[indexPath.item]] as? String {
               // show the sprite
               if let imageView = cell.viewWithTag(100) as? UIImageView {
                   //get the image from the URL
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
