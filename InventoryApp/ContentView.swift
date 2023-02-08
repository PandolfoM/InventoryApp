//
//  ContentView.swift
//  Inventory
//
//  Created by Matt Pandolfo on 1/5/23.
//

import CoreData
import SwiftUI

struct ContentView: View {
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var categories: FetchedResults<Category>

  @State private var isPresented = false
  @State private var isPresented2 = false
  @State private var categoryName = ""
  @State private var currentCategory = ""

  var body: some View {
    VStack {
      if categories.count > 0 {
        List {
          Section("My Collections") {
            ForEach(categories, id: \.self) { category in
              NavigationLink {
                CategoryView(filter: category.wrappedName, category: category.wrappedName)
                  .navigationTitle(category.wrappedName)
              } label: {
                HStack {
                  Text(category.wrappedName)
                  Spacer()
                  Text("\(category.itemArray.count)")
                }
              }
            }
            .onDelete(perform: deleteItem)
            .swipeActions(edge: .leading) {
              Button("Edit") {
                isPresented2.toggle()
              }
              .tint(.green)
            }
          }
          RecentlyAdded()
        }
        .alert("Edit Collection", isPresented: $isPresented2, actions: {
          TextField("Name", text: $categoryName)

          Button("Edit") {
            if categoryName == "" {
              return
            }
            categoryName = ""
          }
          Button("Cancel", role: .cancel, action: {})
        }, message: {
          Text("Please enter a collection name")
        })
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            EditButton()
          }

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
                let category = Category(context: moc)
                category.name = categoryName
                categoryName = ""
                try? moc.save()
              }
              Button("Cancel", role: .cancel, action: {})
            }, message: {
              Text("Please enter a collection name")
            })
          }
        }
      } else {
        VStack {
          Text("No Collections").font(.largeTitle).fontWeight(.medium)
          Button("Add Collection") {
            isPresented.toggle()
          }.font(.title3)
        }
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
                let category = Category(context: moc)
                category.name = categoryName
                categoryName = ""
                try? moc.save()
              }
              Button("Cancel", role: .cancel, action: {})
            }, message: {
              Text("Please enter a collection name")
            })
          }
        }
      }
    }
  }

  func deleteItem(at offsets: IndexSet) {
    for offset in offsets {
      let item = categories[offset]
      moc.delete(item)
    }

    try? moc.save()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
