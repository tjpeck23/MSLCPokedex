//
//  Pokemon.swift
//  MSLCPokedex
//
//  Created by Travis Peck on 9/18/24.
//  https://pokeapi.co/api/v2/pokemon?limit=151
//  We will be using the Codable Protocol in swift to easily import the json of pokemon information

import Foundation

struct Pokemon : Codable {
    var results: [PokemonEntry]
}

struct PokemonEntry: Codable, Identifiable {
    let id = UUID()
    var name: String
    var url: String
}

class PokeApi {
    func getData(completion: @escaping ([PokemonEntry]) -> ()) {
        guard let url = URL("https://pokeapi.co/api/v2/pokemon?limit=151") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error)  in
            guard let data = data else { return }
            
            let pokemonList = try! JSONDecoder().decode(Pokemon.self, from: data)
            
            DispatchQueue.main.async {
                completion(pokemonList.results)
            }
        }.resume()
    }
}
