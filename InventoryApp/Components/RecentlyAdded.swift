//
//  RecentlyAddedView.swift
//  InventoryApp
//
//  Created by Matt Pandolfo on 2/7/23.
//
import CoreData
import SwiftUI

struct RecentlyAdded: View {
  @FetchRequest var items: FetchedResults<Item>

  init() {
    let request: NSFetchRequest<Item> = Item.fetchRequest()
    request.sortDescriptors = [
      NSSortDescriptor(keyPath: \Item.date, ascending: false)
    ]
    request.predicate = NSPredicate(format: "origin != nil")
    request.fetchLimit = 5

    _items = FetchRequest(fetchRequest: request)
  }

  var body: some View {
    if items.count > 0 {
      Section("Recently Added") {
        ForEach(items.prefix(5), id: \.self) { item in
          ItemList(item: item)
        }
      }
    }
  }
}

struct RecentlyAdded_Previews: PreviewProvider {
  static var previews: some View {
    RecentlyAdded()
  }
}
