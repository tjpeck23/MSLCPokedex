//
//  Pokemon.swift
//  MSLCPokedex
//
//  Created by Travis Peck on 9/18/24.
//  https://pokeapi.co/api/v2/pokemon?limit=151
//  We will be using the Codable Protocol in swift to easily import the json of pokemon information

import Foundation


class PokeApi {
    var pokemon: Pokemon?
    
    func getData() async throws -> Pokemon {
        
        let endpoint = "https://pokeapi.co/api/v2/pokemon?limit=151"
        
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            return try decoder.decode(Pokemon.self, from: data)
        } catch {
            throw APIError.invalidData
        }
    }
    
    //The following functions are to create dictionaries in order to easily grab the info we want. Also, Structs can not be accessed by Objective-c.
    
    func createPokemonUrlDict(pokemon: Pokemon) -> NSMutableDictionary{
        let pokemonDict: NSMutableDictionary = [:]
        for pokemonEntry in pokemon.results {
            pokemonDict[pokemonEntry.name] = pokemonEntry.url
        }
        return pokemonDict
    }
    
    func createPokemonIdDict(pokemon: Pokemon) -> NSMutableDictionary{
        let pokemonDict: NSMutableDictionary = [:]
        var iterator = 1
        for pokemonEntry in pokemon.results {
            pokemonDict[pokemonEntry.name] = iterator
            iterator += 1
        }
        return pokemonDict
    }
    
    func createPokemonSpriteDict(pokemon: Pokemon) -> NSMutableDictionary{
        let pokemonDict: NSMutableDictionary = [:]
        var iterator = 1
        for pokemonEntry in pokemon.results {
            pokemonDict[pokemonEntry.name] = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/transparent/1.png"
            iterator += 1
        }
        return pokemonDict
    }
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    
}

struct Pokemon : Codable {
    var results: [PokemonEntry]
}

struct PokemonEntry: Codable{
    var name: String
    var url: String
}
