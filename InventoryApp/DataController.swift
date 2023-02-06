//
//  DataCntroller.swift
//  InventoryApp
//
//  Created by Matt Pandolfo on 2/3/23.
//

import CoreData
import Foundation

class DataController: ObservableObject {
  let container = NSPersistentContainer(name: "Stockify")

  init() {
    container.loadPersistentStores { _, error in
      if let error = error {
        print("Core Data failed to load: \(error.localizedDescription)")
        return
      }

      self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
  }
}
