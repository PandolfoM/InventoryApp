//
//  ContentView.swift
//  Inventory
//
//  Created by Matt Pandolfo on 1/5/23.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var data: InventoryItems
  @State private var isPresented = false
  @State private var isPresented2 = false
  @State private var categoryName = ""
  @State var currentGroup: Category

  var body: some View {
    List {
      Section("My Collections") {
        if data.ItemCategories.count > 0 {
          ForEach(data.ItemCategories) { group in
            NavigationLink {
              CategoryView(category: group)
                .navigationTitle(group.name)
            } label: {
              HStack {
                Text(group.name)
                Spacer()
                Text("\(group.items.count)")
              }
            }
            .swipeActions(edge: .leading) {
              Button("Edit") {
                currentGroup = group
                isPresented2 = true
              }

              .tint(.green)
            }
          }
          .onDelete { indexSet in
            data.deleteCat(indexSet)
          }
        } else {
          Text("No Collections")
            .font(.largeTitle)
        }
      }
    }
    .alert("Edit Collection", isPresented: $isPresented2, actions: {
      TextField("Name", text: $categoryName)

      Button("Edit") {
        if categoryName == "" {
          return
        }
        data.editCategory(categoryName, category: currentGroup)
        categoryName = ""
      }
      Button("Cancel", role: .cancel, action: {})
    }, message: {
      Text("Please enter a collection name")
    })
    .toolbar {
      ToolbarItem {
        Button {
          isPresented = true
        } label: {
          Image(systemName: "plus")
        }
        .alert("Create Collection", isPresented: $isPresented, actions: {
          TextField("Name", text: $categoryName)

          Button("Create") {
            if categoryName == "" {
              return
            }
            data.addCategory(categoryName)
            categoryName = ""
          }
          Button("Cancel", role: .cancel, action: {})
        }, message: {
          Text("Please enter a collection name")
        })
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(currentGroup: Category(name: "", items: []))
      .environmentObject(InventoryItems())
  }
}
