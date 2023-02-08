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
            HStack {
              Text("x\(item.count)")
                .foregroundColor(.gray)
                .font(.subheadline)
              Text("\(item.origin?.wrappedName ?? "Unknown")")
                .foregroundColor(.gray)
                .font(.subheadline)

            }.frame(maxWidth: 170, alignment: .leading)
            Spacer()
            Text(item.name ?? "Unknown")
              .font(.headline)
              .frame(width: 170, alignment: .leading)
            Spacer()
            item.date.timeAgo()
              .foregroundColor(.gray)
              .font(.subheadline)
              .frame(width: 170, alignment: .leading)
          }.frame(width: 170, alignment: .leading)
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
