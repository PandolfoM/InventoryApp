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
            timeCheck(item: item)
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

  func timeCheck(item: Item) -> Text {
    let dateDiff = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: item.date, to: Date())
    let minute = dateDiff.minute ?? 0
    let hour = dateDiff.hour ?? 0
    let day = dateDiff.day ?? 0
    let month = dateDiff.month ?? 0
    let year = dateDiff.year ?? 0
    if minute < 1 {
      return Text("Now")
    } else if minute == 1 {
      return Text("1 Minute ago")
    } else if minute > 1 {
      return Text("\(minute) Minutes ago")
    } else if hour == 1 {
      return Text("1 Hour ago")
    } else if hour > 1 {
      return Text("\(hour) Hours ago")
    } else if day == 1 {
      return Text("1 Day ago")
    } else if day > 1 {
      return Text("\(day) Days ago")
    } else if month == 1 {
      return Text("1 Month ago")
    } else if month > 1 {
      return Text("\(month) Months ago")
    } else if year == 1 {
      return Text("1 Year ago")
    } else {
      return Text("\(year) Years ago")
    }
  }
}

struct RecentlyAdded_Previews: PreviewProvider {
  static var previews: some View {
    RecentlyAdded()
  }
}
