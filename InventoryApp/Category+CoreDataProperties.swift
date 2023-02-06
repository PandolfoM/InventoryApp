//
//  Category+CoreDataProperties.swift
//  InventoryApp
//
//  Created by Matt Pandolfo on 2/3/23.
//
//

import CoreData
import Foundation

public extension Category {
  @nonobjc class func fetchRequest() -> NSFetchRequest<Category> {
    return NSFetchRequest<Category>(entityName: "Category")
  }

  @NSManaged var name: String?
  @NSManaged var item: NSSet?

  var wrappedName: String {
    name ?? "Unknown Category"
  }

  var itemArray: [Item] {
    let set = item as? Set<Item> ?? []

    return set.sorted {
      $0.wrappedName < $1.wrappedName
    }
  }
}

// MARK: Generated accessors for item

public extension Category {
  @objc(addItemObject:)
  @NSManaged func addToItem(_ value: Item)

  @objc(removeItemObject:)
  @NSManaged func removeFromItem(_ value: Item)

  @objc(addItem:)
  @NSManaged func addToItem(_ values: NSSet)

  @objc(removeItem:)
  @NSManaged func removeFromItem(_ values: NSSet)
}

extension Category: Identifiable {}
