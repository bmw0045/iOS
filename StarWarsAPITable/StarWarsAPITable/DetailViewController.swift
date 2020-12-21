//
//  DetailViewController.swift
//  StarWarsAPITable
//
//  Created by Field Employee on 12/18/20.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    var myCharacter: SWCharacterResult!
    var myPlanet: HomeWorld!
    
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hairLabel: UILabel!
    @IBOutlet weak var eyeLabel: UILabel!
    @IBOutlet weak var planetLabel: UILabel!
    @IBOutlet weak var filmsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Info"
        getPlanet()
        getFilms()
        self.nameLabel.text = myCharacter.name
        self.hairLabel.text? = "Hair Color: \(myCharacter.hair.capitalized)"
        self.eyeLabel.text = "Eye Color: \(myCharacter.eyes.capitalized)"
        self.filmsLabel.text = "Films: \(getFilms())"
    }
    
    func getPlanet() {
        guard let urlObj = URL(string: myCharacter.planet) else {return}
        URLSession.shared.dataTask(with: urlObj) {[weak self](data, response, error) in
            guard let data = data else {return}
            do {
               let downloadedWorld = try JSONDecoder().decode(HomeWorld.self, from: data)
                
                DispatchQueue.main.async {
                    self?.planetLabel.text = downloadedWorld.name
                }
            }
           catch {
                print(error)
            }
           }
        .resume()
    }
    
    func getFilms() {
        let films: [String] = myCharacter.films
        var i = 0
        for _ in films {
            guard let urlObj = URL(string: "\(myCharacter.films[i])") else {return}
        URLSession.shared.dataTask(with: urlObj) {[weak self](data, response, error) in
            guard let data = data else {return}
            do {
               let downloadedFilm = try JSONDecoder().decode(Films.self, from: data)
                
                DispatchQueue.main.async {
                    self?.filmsLabel.text = downloadedFilm.title
                    i += 1
                }
            }
           catch {
                print(error)
                }
        }.resume()
    }
    }

}
