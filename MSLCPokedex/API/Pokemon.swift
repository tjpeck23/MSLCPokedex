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
