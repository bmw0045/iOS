//
//  DatabaseHelper.swift
//  CoreDataAPI
//
//  Created by Field Employee on 12/27/20.
//

import Foundation
import CoreData
import UIKit

protocol shipDB {
    func createOrUpdateShip()
}

class ShipDBObject: NSManagedObject {
    
    class func getTheShipWith(registryNumber number: String) -> ShipEntity? {
        let request : NSFetchRequest<ShipEntity> = ShipEntity.fetchRequest()
        request.predicate = NSPredicate(format: "registryNumber == %@", number)
        return try? AppDelegate.viewContext.fetch(request).first
    }
    
    func createOrUpdateShip(price shipPrice: String, shipDescription descrip: String, title shipTitle: String, registryNumber regNo: String) -> ShipEntity {
        
        let request : NSFetchRequest<ShipEntity> = ShipEntity.fetchRequest()
        request.predicate = NSPredicate(format: "registryNumber == %@", regNo)
       
        
        let ship = ShipEntity(context: AppDelegate.viewContext)
        ship.title = shipTitle
        ship.shipDescription = descrip
        ship.price = shipPrice
        ship.registryNumber = regNo
        
        DispatchQueue.main.async {
            try? AppDelegate.viewContext.save()
        }
        
        return ship
    }
    
    
    
}
