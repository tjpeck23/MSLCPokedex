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
    //create timer
    var timer: Timer?
    

    
    //create timer
    var timer: Timer?
    

    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //start the timer so it gets the stuff from the API
        startTimer()
    }
    
    func startTimer() {
            timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(getPokemonData), userInfo: nil, repeats: true)
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
                printPokemon(pokemon)
            } catch {
                print("Failed to fetch Pokemon")
            }
        }
    }
    
    func printPokemon(_ pokemon: Pokemon) {
        for pokemonEntry in pokemon.results {
            print("Pokemon Name: \(pokemonEntry.name), URL: \(pokemonEntry.url)")
        }
    }
    
    
    //stop timer when view isnt being used
    deinit{
        timer?.invalidate()
    }
    
    @IBAction func Button1(_ sender: Any) {
        
    }
    
}

