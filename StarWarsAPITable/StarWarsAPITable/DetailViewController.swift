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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPlanet()
        self.nameLabel.text = myCharacter.name
        self.hairLabel.text? = "Hair Color: \(myCharacter.hair.capitalized)"
        self.eyeLabel.text = "Eye Color: \(myCharacter.eyes.capitalized)"
        
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
    
    
}
