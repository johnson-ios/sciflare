//
//  Item+CoreDataProperties.swift
//  sciflarePro
//
//  Created by Briston on 18/07/24.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var mobile: String?
    @NSManaged public var gender: String?

}

extension Item : Identifiable {

}
