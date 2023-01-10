//
//  InventoryItems.swift
//  Inventory
//
//  Created by Matt Pandolfo on 1/5/23.
//

import SwiftUI

class InventoryItems: ObservableObject {
  @Published var ItemCategories: [Category]
  let saveKey = "ITEMS_SAVED"

  init() {
    if let data = UserDefaults.standard.data(forKey: saveKey) {
      if let decoded = try? JSONDecoder().decode([Category].self, from: data) {
        ItemCategories = decoded
        return
      }
    }
    // no saved data
    ItemCategories = []
  }

  private func save() {
    if let encoded = try? JSONEncoder().encode(ItemCategories) {
      UserDefaults.standard.set(encoded, forKey: saveKey)
    }
  }

  func deleteCat(_ category: IndexSet) {
    ItemCategories.remove(atOffsets: category)
    save()
  }

  func deleteItem(_ indexSet: IndexSet, category: Category) {
    let index = ItemCategories.firstIndex(where: { $0.id == category.id })
    ItemCategories[index!].items.remove(atOffsets: indexSet)
    save()
  }

  func addItem(_ itemName: String, itemCount: Int, image: Data?, category: Category) {
    let newItem = Item(name: itemName, image: image, count: itemCount)
    let index = ItemCategories.firstIndex(where: { $0.id == category.id })
    ItemCategories[index!].items.append(newItem)
    save()
  }

  func addCategory(_ categoryName: String) {
    ItemCategories.append(Category(name: categoryName, items: []))
    save()
  }

  func editCategory(_ categoryName: String, category: Category) {
    let index = ItemCategories.firstIndex(where: { $0.id == category.id })
    let updatedItem = Category(name: categoryName, items: ItemCategories[index!].items)
    ItemCategories[index!] = updatedItem
    save()
  }

  func updateItem(_ itemName: String, itemCount: Int, image: Data?, category: Category, item: Item) {
    let newItem = Item(name: itemName, image: image, count: itemCount)
    let index = ItemCategories.firstIndex(where: { $0.id == category.id })
    let itemIndex = ItemCategories[index!].items.firstIndex(where: { $0.id == item.id })
    ItemCategories[index!].items[itemIndex!] = newItem
    save()
  }
}

struct Item: Identifiable, Codable {
  var name: String
  var image: Data?
  var count: Int = 1

  var id = UUID()
}

struct Category: Identifiable, Codable {
  var name: String
  var items: [Item]

  var id = UUID()
}
