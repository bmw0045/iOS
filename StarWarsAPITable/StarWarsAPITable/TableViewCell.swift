//
//  TableViewCell.swift
//  StarWarsAPITable
//
//  Created by Field Employee on 12/18/20.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var eyeLabel: UILabel!
//    @IBOutlet weak var hairLabel: UILabel!
//    @IBOutlet weak var planetLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    func configure(with character: SWCharacterResult) {
        self.nameLabel.text = character.name
        //self.eyeLabel.text = "E: \(character.eyes)"
        //self.hairLabel.text = "H: \(character.hair)"
        //self.planetLabel.text = planet.name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
