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

//      Button("Add Examples") {
//        let item1 = Item(context: moc)
//        item1.name = "Star Destroyer"
//        item1.origin = Category(context: moc)
//        item1.origin?.name = "Lego"
//
//        let item2 = Item(context: moc)
//        item2.name = "Gunship"
//        item2.origin = Category(context: moc)
//        item2.origin?.name = "Lego"
//
//        let item3 = Item(context: moc)
//        item3.name = "AtAt"
//        item3.origin = Category(context: moc)
//        item3.origin?.name = "Lego"
//
//        let item4 = Item(context: moc)
//        item4.name = "GoXLR"
//        item4.origin = Category(context: moc)
//        item4.origin?.name = "Tech"
//
//        try? moc.save()
//      }
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
