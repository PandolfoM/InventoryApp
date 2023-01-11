//
//  CategoryItems.swift
//  Inventory
//
//  Created by Matt Pandolfo on 1/6/23.
//

import SwiftUI

struct CategoryView: View {
  var category: Category
  @EnvironmentObject var data: InventoryItems
  @State private var isPresented = false
  @State private var itemName = ""
  @State private var isFullscreen = false

  var body: some View {
    List {
      if category.items.count > 0 {
        ForEach(category.items) { item in
          HStack {
            VStack {
              Text("x\(item.count)")
                .foregroundColor(.blue)
                .frame(width: 170, alignment: .leading)
                .font(.subheadline)
              Spacer()
              Text(item.name)
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
              ItemEdit(category: category, item: item)
                .navigationTitle("Edit Item")
                .navigationBarTitleDisplayMode(.inline)
            }
            .tint(.green)
          }
        }
        .onDelete { indexSet in
          data.deleteItem(indexSet, category: category)
        }
      } else {
        Text("No Items")
          .font(.largeTitle)
      }
    }.toolbar {
      ToolbarItem {
        NavigationLink {
          ItemAdd(category: category)
            .navigationTitle("Add Item")
            .navigationBarTitleDisplayMode(.inline)
        } label: {
          Image(systemName: "plus")
        }
      }
    }
  }
}

struct Previews_CategoryView_Previews: PreviewProvider {
  static var previews: some View {
    CategoryView(category: Category(name: "Lego", items: [
      Item(name: "UCS Star Destroyer"),
      Item(name: "Repiblic Gunship"),
    ]))
  }
}
