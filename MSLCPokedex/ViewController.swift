//
//  ViewController.swift
//  MSLCPokedex
//
//  Created by Travis Peck on 9/17/24.
//

import UIKit

class ViewController: UIViewController {

    let pokeApi = PokeApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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

}

