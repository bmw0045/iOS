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
    var totalPokemon = 151
    var pokeBatch: [Pokemon] = []
    let baseURL: String = "https://pokeapi.co/api/v2/pokemon/"
    var itemsPerBatch = 30
    var offset = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pokemonTableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonTableViewCell")
        self.pokemonTableView.dataSource = self
        self.pokemonTableView.delegate = self
        self.pokemonTableView.prefetchDataSource = self
        //self.fetchPokemon()
        //self.getAllPokemon()
        self.getAllPokemon()
        
        
        
        // Do any additional setup after loading the view.
    }

    func fetchPokemon() {
        var pokeLinkArr: [String] = []
        for i in 1...151 {
            let iString = "\(i)"
            let pokeLink = "https://pokeapi.co/api/v2/pokemon/" + iString
            pokeLinkArr.append(pokeLink)
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
//    private func getAllPokemon(pageNumber: Int, completion: @escaping () -> Void) {
//        let group = DispatchGroup()
//        for i in 1...151 {
//            group.enter()
//            let iString = "\(i)"
//            NetworkManager.shared.getDecodedObject(from: self.createPokemonURL() + iString) {
//                (pokemon: Pokemon?, error) in
//                guard let pokemon = pokemon else {return}
//                self.pokeBatch.append(pokemon)
//                group.leave()
//            }
//            self.pokemonArray += pokeBatch
//            completion()
//        }
//        group.notify(queue: .main) {
//            //self.pokemonTableView.reloadData()
//        }
//    }
//    private func getAllPokemon() {
//        let group = DispatchGroup()
//        var i = 30
//        for _ in 1...5 {
//            group.enter()
//            let iString = "\(i)"
//            NetworkManager.shared.getDecodedObject(from: self.createPokemonURL() + iString) {
//                (pokemon: Pokemon?, error) in
//                guard let pokemon = pokemon else {return}
//                self.pokemonArray.append(pokemon)
//                group.leave()
//            }
//            i += 30
//        }
//        group.notify(queue: .main) {
//            self.pokemonTableView.reloadData()
//        }
//    }
//    private func getAllPokemon() {
//        let group = DispatchGroup()
//        for _ in 1...151 {
//            group.enter()
//           // let iString = "\(i)"
//            NetworkManager.shared.getDecodedObject(from: self.createPokemonURL()) { (pokemon: Pokemon?, error) in
//                guard let pokemon = pokemon else {
//                    if let error = error {
//                        let alert = self.generateAlert(from: error)
//                        DispatchQueue.main.async {
//                            self.present(alert, animated: true, completion: nil)
//                        }
//                    }
//                    return
//                }
//                DispatchQueue.main.async {
//                    self.pokemonTextLabel?.text = pokemon.name
//                }
//                NetworkManager.shared.getImageData(from: (pokemon.sprites.frontDefault)!) {data, error in
//                    guard let data = data else {return}
//                    DispatchQueue.main.async {
//                        self.pokemonImageView?.image = UIImage(data: data)
//                    }
//                }
//            }
//        }
//    }
    
    private func generateAlert(from error: Error) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: "We ran into an Error Description: \(error.localizedDescription)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        return alert
    }
}



extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        let lastIndexPath = indexPath.row
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

extension ViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let lastIndexPath = IndexPath(row: self.pokemonArray.count - 1, section: 0)
        guard indexPaths.contains(lastIndexPath) else {return}
        //self.pageNumber += 1
        DispatchQueue.main.async {
            self.pokemonTableView.reloadData()
        }
        //self.getAllPokemon()
    }
}

