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

extension Date {
  func timeAgo() -> Text {
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .full
    formatter.allowedUnits = [.year, .month, .day, .hour, .minute]
    formatter.zeroFormattingBehavior = .dropAll
    formatter.maximumUnitCount = 1
    let final = String(format: formatter.string(from: self, to: Date()) ?? "", locale: .current)
    if final == "0 minutes" {
      return Text("Now")
    } else {
      return Text("\(final) ago")
    }
  }
}

struct RecentlyAdded_Previews: PreviewProvider {
  static var previews: some View {
    RecentlyAdded()
  }
}
