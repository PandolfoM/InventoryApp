//
//  Item+CoreDataProperties.swift
//  InventoryApp
//
//  Created by Matt Pandolfo on 2/3/23.
//
//

import CoreData
import Foundation

public extension Item {
  @nonobjc class func fetchRequest() -> NSFetchRequest<Item> {
    return NSFetchRequest<Item>(entityName: "Item")
  }

  @NSManaged var name: String?
  @NSManaged var image: Data?
  @NSManaged var count: Int16
  @NSManaged var date: Date
  @NSManaged var origin: Category?

  internal var wrappedName: String {
    name ?? "Unknown Item"
  }
}

extension Item: Identifiable {}
