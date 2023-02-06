//
//  ItemEdit.swift
//  Inventory
//
//  Created by Matt Pandolfo on 1/10/23.
//

import PhotosUI
import SwiftUI

struct ItemEdit: View {
  @Environment(\.managedObjectContext) var moc
  @Environment(\.dismiss) var dismiss
  @FetchRequest var items: FetchedResults<Item>
  @State private var itemName = ""
  @State private var itemCount: Int16 = 1
  @State private var selectedItem: PhotosPickerItem?
  @State private var selectedPhotoData: Data?

  init(filter: String) {
    print(filter)
    _items = FetchRequest<Item>(sortDescriptors: [], predicate: NSPredicate(format: "name == %@", filter))
  }

  var body: some View {
    VStack {
      Form {
        ForEach(items, id: \.self) { item in
          Section("Item Name") {
            TextField("Name", text: $itemName)
              .onAppear {
                self.itemName = item.wrappedName
              }
          }

          Section("Quantity") {
            Stepper("Quanity: \(itemCount)", value: $itemCount, in: 1 ... 32767)
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
            item.name = itemName
            item.count = itemCount
            item.image = selectedPhotoData

            try? moc.save()
            dismiss()
          }
        }
      }
    }
  }
}

struct ItemEdit_Previews: PreviewProvider {
  static var previews: some View {
    ItemEdit(filter: "Gunship")
  }
}
