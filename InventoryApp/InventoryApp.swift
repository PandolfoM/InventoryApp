//
//  InventoryApp.swift
//  Inventory
//
//  Created by Matt Pandolfo on 1/5/23.
//

import SwiftUI

@main
struct InventoryApp: App {
  @StateObject private var dataController = DataController()

  var body: some Scene {
    WindowGroup {
      NavigationStack {
        ContentView()
          .navigationTitle("Inventory")
      }.environment(\.managedObjectContext, dataController.container.viewContext)
    }
  }
}
