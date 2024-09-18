//
//  ContentView.swift
//  MSLCPokedex
//
//  Created by Travis Peck on 9/18/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View{
        Text("Hello, World")
            .padding()
            .onAppear {
                PokeApi().getData() {pokemon in
                    print(pokemon)
                    
                    for pokemon in pokemon {
                        print(pokemon.name)
                    }
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
