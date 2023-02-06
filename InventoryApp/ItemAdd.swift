//
//  ItemAdd.swift
//  Inventory
//
//  Created by Matt Pandolfo on 1/6/23.
//

import PhotosUI
import SwiftUI

struct ItemAdd: View {
  @Environment(\.dismiss) var dismiss
  @Environment(\.managedObjectContext) var moc

  @State private var itemName = ""
  @State private var itemCount: Int16 = 1
  @State private var selectedItem: PhotosPickerItem?
  @State private var selectedPhotoData: Data?

  var body: some View {
    VStack {
      Form {
        Section("Item Name") {
          TextField("Name", text: $itemName)
        }

        Section("Quantity") {
          Stepper("Quanity: \(itemCount)", value: $itemCount, in: 1 ... 32767)
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

        Button("Add Item") {
          if itemName == "" {
            return
          }
          let item = Item(context: moc)
          item.name = itemName
          item.count = itemCount
          item.image = selectedPhotoData
          item.origin = Category(context: moc)
          item.origin?.name = "Lego"
          try? moc.save()
          dismiss()
        }
      }
    }
  }
}

struct ItemAdd_Previews: PreviewProvider {
  static var previews: some View {
    ItemAdd()
  }
}
