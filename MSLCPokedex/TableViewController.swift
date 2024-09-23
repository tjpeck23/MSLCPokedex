//
//  TableViewController.swift
//  MSLCPokedex
//
//  Created by Cady Studdard on 9/22/24.
//


//use this class in order to show first 5 pokemon shown's information
import UIKit

class TableViewController: UITableViewController{
    
    //variables to hold the pokemon data (i.e names, sprites, id)
    var pokemonData: [(pokeName: String, pokeImage: String, pokeID: Int)] = []
    
    //this goes in every class
    override func viewDidLoad() {
            super.viewDidLoad()
            
        }
    
    // MARK: - Table view data source
    
    
    //number of sections in the table
    override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

    //gives us the num of pokemon info to show
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return pokemonData.count
        }
    
    
    //had to use stackover flow to get the 3 cases down
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let pokemon = pokemonData[indexPath.row]
            
            // Dynamically choose which cell to use based on the index
            switch indexPath.row % 3 {
            case 0:
                // get and show Poke Name
                let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
                cell.textLabel?.text = pokemon.pokeName
                return cell
                
            case 1:
                // get and show Image
                let cell = tableView.dequeueReusableCell(withIdentifier: "spriteCell", for: indexPath)
                if let imageView = cell.viewWithTag(100) as? UIImageView {
                    updateImageView(imageView, with: pokemon.pokeImage)
                }
                return cell
                
            case 2:
                // the ID or just number
                let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
                cell.textLabel?.text = "ID: \(pokemon.pokeID)"
                return cell
                
            default:
                fatalError("Unexpected row")
            }
        }
    
    func updateImageView(_ imageView: UIImageView, with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        // get the sprites from view controller I think which gets it from the API
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
