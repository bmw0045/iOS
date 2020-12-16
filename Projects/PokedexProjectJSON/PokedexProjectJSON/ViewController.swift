//
//  ViewController.swift
//  PokedexProjectJSON
//
//  Created by Field Employee on 12/12/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pokemonTableView: UITableView!
    @IBOutlet weak var pokemonImageView: UIImageView?
    @IBOutlet weak var pokemonTextLabel: UILabel?
    var pokemonArray: [Pokemon] = []
    var totalPokemon = 150
    var pokeBatch: [Result] = []
    var nextURL: String = ""
    var itemsPerBatch = 30
    var offset = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pokemonTableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonTableViewCell")
        self.pokemonTableView.dataSource = self
        self.pokemonTableView.delegate = self
        //self.pokemonTableView.prefetchDataSource = self
        self.getAllPokemon()
        self.getInitialData()
        // Do any additional setup after loading the view.
    }

    func getInitialData() {
        pokeBatch = []
        nextURL = "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=30"
        getPokemonData()
    }
    func getPokemonData() {
        if isArrayFull() == false {
         guard let urlObj = URL(string: nextURL) else {return}
         URLSession.shared.dataTask(with: urlObj) {[weak self](data, response, error) in
             guard let data = data else {return}
             do {
                 let downloadedPokemon = try JSONDecoder().decode(PaginatedPokemon.self, from: data)
                self?.pokeBatch.append(contentsOf: downloadedPokemon.results)
                 self?.nextURL = downloadedPokemon.next
                 
                 DispatchQueue.main.async {
                     self?.pokemonTableView.reloadData()
                 }
             }
            catch {
                 print(error)
             }
            }
         .resume()
        }
     }

    func createPokemonURL() -> String {
        let apiLink = "https://pokeapi.co/api/v2/pokemon/"
        return apiLink
    }
    
    private func getAllPokemon() {
        let group = DispatchGroup()
        for i in 1...151 {
            group.enter()
            let iString = "\(i)"
            NetworkManager.shared.getDecodedObject(from: self.createPokemonURL() + iString) {
                (pokemon: Pokemon?, error) in
                guard let pokemon = pokemon else {return}
                self.pokemonArray.append(pokemon)
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.pokemonTableView.reloadData()
        }
    }
    
    func isArrayFull() -> Bool {
        if pokeBatch.count < totalPokemon { return false}
        else {
            return true
        }
    }
    
    private func generateAlert(from error: Error) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: "We ran into an Error Description: \(error.localizedDescription)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        return alert
    }
}



extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokeBatch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let count = pokeBatch.count
            let lastElement = count - 1
            if indexPath.row == lastElement {
                getPokemonData()
            }
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell", for: indexPath) as! PokemonTableViewCell
        cell.configure(with: self.pokemonArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailVCSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //let lastIndexPath = indexPath.row
        if indexPath.row == pokemonArray.count - 1 {
            if pokemonArray.count < totalPokemon {
                //self.getAllPokemon(pageNumber)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.myPokemon = pokemonArray[pokemonTableView.indexPathForSelectedRow!.row]
        }
    }
}

//extension ViewController: UITableViewDataSourcePrefetching {
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        let lastIndexPath = IndexPath(row: self.pokemonArray.count - 1, section: 0)
//        guard indexPaths.contains(lastIndexPath) else {return}
//        //self.pageNumber += 1
//        DispatchQueue.main.async {
//            self.pokemonTableView.reloadData()
//        }
//        //self.getAllPokemon()
//    }
//}

