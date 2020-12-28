//
//  TableViewCell.swift
//  CoreDataAPI
//
//  Created by Field Employee on 12/27/20.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var userLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with ship: Ship) {
        self.userLabel.text = ship.title
    }
    
}
