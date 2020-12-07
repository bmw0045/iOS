//
//  ViewController.swift
//  PokedexProject
//
//  Created by Field Employee on 12/4/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // let mySingleton = TheSingleton.shared
        //parseDataJSONSerialization()
        parseDataCodable()
    }
    
//    func parseDataJSONSerialization() {
//        guard let fileURL = Bundle.main.url(forResource: "PokemonExample", withExtension: "json") else {return}
//        print(fileURL)
//        guard let fileData = try? Data(contentsOf: fileURL) else {return}
//        print(fileData)
//        guard let parsedJSON = try? JSONSerialization.jsonObject(with: fileData, options: []) as? [String: Any] else {return}
//        print(Pokemon(json: parsedJSON))
//    }
    
    func parseDataCodable() {
        guard let fileURL = Bundle.main.url(forResource: "PokemonExample", withExtension: "json") else {return}
        print(fileURL)
        guard let fileData = try? Data(contentsOf: fileURL) else {return}
        print(fileData)
        let pokemon = try? JSONDecoder().decode(CodablePokemon.self, from: fileData)
        print(pokemon)
    }
}
