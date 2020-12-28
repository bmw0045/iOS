//
//  DatabaseHelper.swift
//  CoreDataAPI
//
//  Created by Field Employee on 12/27/20.
//

import Foundation
import CoreData
import UIKit

class SWCharacterDBObject: NSManagedObject {
    
    class func getTheCharWith(registryNumber number: String) -> ShipEntity? {
        let request : NSFetchRequest<ShipEntity> = ShipEntity.fetchRequest()
        request.predicate = NSPredicate(format: "registryNumber == %@", number)
        return try? AppDelegate.viewContext.fetch(request).first
    }
    
    
}
