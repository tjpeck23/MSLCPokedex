//
//  ViewController.swift
//  MSLCPokedex
//
//  Created by Travis Peck on 9/17/24.
//

import UIKit

class ViewController: UIViewController {

    let pokeApi = PokeApi()
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        // Loads the API data asynchronously
        Task {
            do {
                let pokemon = try await pokeApi.getData()
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
    
    @IBAction func Button1(_ sender: Any) {
        
    }
    
}

