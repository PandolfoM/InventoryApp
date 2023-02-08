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
  @State private var imageFullscreen = false
  @State private var currentImage: UIImage?

  init(filter: String, category: String) {
    _items = FetchRequest<Item>(sortDescriptors: [SortDescriptor(\.name)], predicate: NSPredicate(format: "origin.name == '\(filter)'"))
    self.category = category
  }

  var body: some View {
    VStack {
      if items.count > 0 {
        List {
          ForEach(items, id: \.self) { item in
            ItemList(item: item, showCategory: false)
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
      } else {
        VStack {
          Text("No Items").font(.largeTitle).fontWeight(.medium)
          NavigationLink(
            destination: ItemAdd(category: category)
              .navigationTitle("Add Item")
              .navigationBarTitleDisplayMode(.inline),
            label: {
              Text("Add Item")
                .font(.title3)
            }
          )
        }
        .toolbar {
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
