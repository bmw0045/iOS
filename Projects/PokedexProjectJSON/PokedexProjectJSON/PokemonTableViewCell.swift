//
//  PokemonTableViewCell.swift
//  PokedexProjectJSON
//
//  Created by Field Employee on 12/13/20.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with pokemon: Pokemon) {
        self.pokemonTextLabel.text = pokemon.name
        NetworkManager.shared.getImageData(from: (pokemon.sprites.frontDefault)!) { (data, error) in
            guard let data = data else {return}
            DispatchQueue.main.async {
                self.pokemonImageView.image = UIImage(data: data)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
