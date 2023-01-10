//
//  ItemEdit.swift
//  Inventory
//
//  Created by Matt Pandolfo on 1/10/23.
//

import PhotosUI
import SwiftUI

struct ItemEdit: View {
  var category: Category
  @State var item: Item
  @EnvironmentObject var data: InventoryItems
  @Environment(\.dismiss) var dismiss

  @State private var itemName = ""
  @State private var itemCount: Int = 1
  @State private var selectedItem: PhotosPickerItem?
  @State private var selectedPhotoData: Data?

  var body: some View {
    VStack {
      Form {
        Section("Item Name") {
          TextField("Name", text: $itemName)
            .onAppear {
              self.itemName = item.name
            }
        }

        Section("Quantity") {
          Stepper("Quanity: \(itemCount)", value: $itemCount, in: 1 ... 999999)
            .onAppear {
              self.itemCount = item.count
            }
        }

        Section("Image") {
          PhotosPicker(selection: $selectedItem, matching: .images) {
            Label("Select a photo", systemImage: "photo")
          }
          .onChange(of: selectedItem) { newItem in
            Task {
              if let data = try? await newItem?.loadTransferable(type: Data.self) {
                selectedPhotoData = data
              }
            }
          }
          .onAppear {
            self.selectedPhotoData = item.image
          }

          if let selectedPhotoData,
             let image = UIImage(data: selectedPhotoData)
          {
            Image(uiImage: image)
              .resizable()
              .scaledToFit()
              .clipped()
              .frame(maxHeight: 200)
          }
        }

        Button("Edit Item") {
          if itemName == "" { return }
          data.updateItem(itemName, itemCount: itemCount, image: selectedPhotoData, category: category, item: item)
          dismiss()
        }
      }
    }
  }
}

struct ItemEdit_Previews: PreviewProvider {
  static var previews: some View {
    ItemEdit(category: Category(name: "Lego", items: [
      Item(name: "UCS Star Destroyer", count: 1),
      Item(name: "UCS Gunship", count: 3),
    ]), item: Item(name: "UCS Star Destroyer", count: 3))
  }
}
