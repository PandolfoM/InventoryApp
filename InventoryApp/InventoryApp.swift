//
//  InventoryApp.swift
//  Inventory
//
//  Created by Matt Pandolfo on 1/5/23.
//

import SwiftUI

@main
struct InventoryApp: App {
  @StateObject var data = InventoryItems()

  var body: some Scene {
    WindowGroup {
      NavigationStack {
        ContentView(currentGroup: Category(name: "", items: []))
          .navigationTitle("Inventory")
      }.environmentObject(data)
    }
  }
}
