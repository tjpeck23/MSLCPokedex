//
//  ViewController.swift
//  MSLCPokedex
//
//  Created by Travis Peck on 9/17/24.
//

import UIKit



class ViewController: UIViewController {
    
    let pokeApi = PokeApi()
    var pokemonUrlDict: NSMutableDictionary = [:]
    var pokemonIdDict: NSMutableDictionary = [:]
    var pokemonSpriteDict: NSMutableDictionary = [:]
    
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var viewAllButton: UIButton!
    @IBOutlet weak var pokemanSprite1: UIImageView!
    @IBOutlet weak var pokemanSprite2: UIImageView!
    @IBOutlet weak var selectTeamLabel: UILabel!
    
    //create timer
    var timer: Timer?
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //start the timer so it gets the stuff from the API
        startTimer()
    }
    
    //button moves to collection view of all pokeman in our API (use the collection view for scroll requriment as well
    
    
    @IBAction func buttonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToCollection", sender: self)
    }
    
    //this button moves to table view which shows the information about all the pokemon
    @IBAction func buttonPressed2(_ sender: Any) {
        performSegue(withIdentifier: "goToTableView", sender: self)
    }
    
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(getPokemonData), userInfo: nil, repeats: true)
    }
    
    @objc func getPokemonData(){
        // Loads the API data asynchronously
        Task {
            do {
                let pokemon = try await pokeApi.getData()
                // Add the info into my Dictionaries for later use.
                pokemonUrlDict = pokeApi.createPokemonUrlDict(pokemon: pokemon)
                pokemonIdDict = pokeApi.createPokemonIdDict(pokemon: pokemon)
                pokemonSpriteDict = pokeApi.createPokemonSpriteDict(pokemon: pokemon)
                //call the func that updates the images every 3 seconds.
                updateSprites()
            } catch {
                print("Failed to fetch Pokemon")
            }
        }
    }
    
    
    func updateSprites() {
        
        //get the keys from the dict
        let keys = pokemonSpriteDict.allKeys
        
        
        // Ensure there are at least two Pokémon to choose from
        guard keys.count >= 2 else { return }
        
        // Select two different random keys
        var randomKeys: [Any] = []
        while randomKeys.count < 2 {
            let randomKey = keys.randomElement()!
            if !randomKeys.contains(where: { $0 as? String == randomKey as? String }) {
                randomKeys.append(randomKey)
            }
        }
        
        // Fetch the sprite URLs using the random keys
        if let spriteUrl1 = pokemonSpriteDict[randomKeys[0]] as? String,
           let spriteUrl2 = pokemonSpriteDict[randomKeys[1]] as? String {
            // Update the UIImageViews with the sprites
            updateImageView(pokemanSprite1, with: spriteUrl1)
            updateImageView(pokemanSprite2, with: spriteUrl2)
        }
    }
    
    
    func updateImageView(_ imageView: UIImageView, with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        // Fetch the image data asynchronously
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
    
    
    func printPokemon(_ pokemon: Pokemon) {
        for pokemonEntry in pokemon.results {
            print("Pokemon Name: \(pokemonEntry.name), URL: \(pokemonEntry.url)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){ //looked this up on stackoverflow to get the APIs to collectionview!
        //sends info to Collection View
        if segue.identifier == "goToCollection" {
                if let destinationVC = segue.destination as? CollectionViewFile {
                    // Check if pokemonSpriteDict has data before passing it
                    if pokemonSpriteDict.count > 0 {
                        print("Sending data: \(pokemonSpriteDict.count) items")
                        destinationVC.pokemonSprites = pokemonSpriteDict
                    } else {
                        print("No data in pokemonSpriteDict")
                    }
                }
            }
        
        
        //sends info to TableView
        if segue.identifier == "goToTableView" {
            if let destinationVC = segue.destination as? TableViewController {
                            if let pokemonNames = pokemonUrlDict.allKeys as? [String] {
                                for name in pokemonNames {
                                    let spriteUrl = pokemonSpriteDict[name] as? String ?? ""
                                    let id = pokemonIdDict[name] as? Int ?? 0
                                    destinationVC.pokemonData.append((pokeName: name, pokeImage: spriteUrl, pokeID: id))
                                }
                            }
                        }
                    }
                }
    
    
}
