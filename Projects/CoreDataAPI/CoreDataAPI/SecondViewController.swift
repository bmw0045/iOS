//
//  SecondViewController.swift
//  CoreDataAPI
//
//  Created by Field Employee on 12/27/20.
//

import Foundation
import UIKit

class SecondViewController : UIViewController, UITextFieldDelegate {
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var textTitle: UITextField!
    @IBOutlet weak var textDescription: UITextField!
    @IBOutlet weak var textPrice: UITextField!
    @IBOutlet weak var textID: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    var myShip : Ship?
    var delegate : ShipCreationDelegate?
    let firstVC = FirstViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if myShip == nil { myShip = Ship(uuid: UUID()) }
        titleLabel.text = myShip?.title
        descriptionLabel.text = myShip?.description
        priceLabel.text = "Price: \(myShip?.price ?? "No Price")"
        idLabel.text = "ID: \(myShip?.id ?? "No ID")"
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        myShip?.title = textTitle.text
    }
    @IBAction func saveDBObject(_ sender: Any) {
        
        let ship = ShipEntity(context: AppDelegate.viewContext)
        ship.registryNumber = self.textID.text ?? "No ID"
        ship.title = self.textTitle.text ?? "No Title"
        ship.shipDescription = self.textDescription.text ?? "No Decription"
        ship.price = self.textPrice.text ?? "No Price"
        
        myShip?.title = self.textTitle.text ?? "no title"
        myShip?.description = self.textDescription.text ?? "no description"
        myShip?.id = self.textID.text ?? "no id"
        myShip?.price = self.textPrice.text!
        firstVC.ships.append(myShip!)
        
                DispatchQueue.main.async {
                    try? AppDelegate.viewContext.save()
                    //self.firstVC.shipsTV.reloadData()
                }
        delegate?.newShipCreated(ship: myShip!, sender: self)
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
