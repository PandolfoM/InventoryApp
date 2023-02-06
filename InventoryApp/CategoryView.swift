//
//  CategoryItems.swift
//  Inventory
//
//  Created by Matt Pandolfo on 1/6/23.
//

import SwiftUI

struct CategoryView: View {
  @Environment(\.managedObjectContext) var moc
  @FetchRequest var items: FetchedResults<Item>
  var category = ""

  init(filter: String, category: String) {
    print(category)
    _items = FetchRequest<Item>(sortDescriptors: [], predicate: NSPredicate(format: "origin.name == '\(filter)'"))
    self.category = category
  }

  var body: some View {
    VStack {
      List {
        ForEach(items, id: \.self) { item in
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
          .swipeActions(edge: .leading) {
            NavigationLink("Edit") {
              ItemEdit(filter: item.wrappedName)
                .navigationTitle("Edit Item")
                .navigationBarTitleDisplayMode(.inline)
            }
            .tint(.green)
          }
        }
        .onDelete(perform: deleteItem)
      }
    }
    .toolbar {
      ToolbarItem {
        EditButton()
      }

      ToolbarItem {
        NavigationLink(
          destination: ItemAdd(category: category)
            .navigationTitle("Add Item")
            .navigationBarTitleDisplayMode(.inline),
          label: {
            Image(systemName: "plus")
          }
        )
      }
    }
  }

  func deleteItem(at offsets: IndexSet) {
    for offset in offsets {
      let item = items[offset]
      moc.delete(item)
    }

    try? moc.save()
  }
}

struct Previews_CategoryView_Previews: PreviewProvider {
  static var previews: some View {
    CategoryView(filter: "", category: "")
  }
}
