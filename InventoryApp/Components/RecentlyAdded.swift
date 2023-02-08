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
    Section("Recently Added") {
      ForEach(items.prefix(5), id: \.self) { item in
        HStack {
          VStack {
            Text("x\(item.count)")
              .foregroundColor(.blue)
              .frame(width: 170, alignment: .leading)
              .font(.subheadline)
            Spacer()
            Text(item.name ?? "Unknown")
              .frame(width: 170, alignment: .leading)
              .font(.headline)
            Spacer()
          }
          Spacer()
          if item.image != nil {
            Image(uiImage: UIImage(data: item.image!)!)
              .renderingMode(.original)
              .resizable()
              .scaledToFit()
              .cornerRadius(10)
              .frame(maxWidth: 170, alignment: .trailing)
          } else {
            Spacer()
          }
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
