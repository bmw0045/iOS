//
//  SecondViewController.swift
//  CoreDataAPI
//
//  Created by Field Employee on 12/27/20.
//

import Foundation
import UIKit

class SecondViewController : UIViewController {
    @IBOutlet weak var textTitle: UITextField!
    @IBOutlet weak var textDescription: UITextField!
    @IBOutlet weak var textPrice: UITextField!
    @IBOutlet weak var textID: UITextField!
    var myShip : Ship?
    let firstVC = FirstViewController()
    
    
    @IBAction func saveDBObject(_ sender: Any) {
        let ship = ShipEntity(context: AppDelegate.viewContext)
        ship.registryNumber = self.textID.text ?? "No ID"
        ship.title = self.textTitle.text ?? "No Title"
        ship.shipDescription = self.textDescription.text ?? "No Decription"
        ship.price = self.textPrice.text ?? "No Price"
        
        myShip?.title = self.textTitle.text ?? "no title"
        myShip?.description = self.textDescription.text ?? "no description"
        myShip?.id = self.textID.text ?? "no id"
        myShip?.price = self.textPrice.text ?? "no price"
        firstVC.ships.append(myShip!)
        
                DispatchQueue.main.async {
                    try? AppDelegate.viewContext.save()
                    self.firstVC.charTableView.reloadData()
                }
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
