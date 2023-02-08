//
//  ItemList.swift
//  InventoryApp
//
//  Created by Matt Pandolfo on 2/8/23.
//

import SwiftUI

struct ItemList: View {
  var item: Item
  var showCategory: Bool = true
  @State private var imageFullscreen = false
  @State private var currentImage: UIImage?
  var body: some View {
    HStack {
      VStack {
        HStack {
          Text("x\(item.count)")
            .foregroundColor(.gray)
            .font(.subheadline)
          if showCategory {
            Text("\(item.origin?.wrappedName ?? "Unknown")")
              .foregroundColor(.gray)
              .font(.subheadline)
          }

        }.frame(maxWidth: 170, alignment: .leading)
        Spacer()
        Text(item.wrappedName)
          .font(.headline)
          .frame(width: 170, alignment: .leading)
        Spacer()
        item.date.timeAgo()
          .foregroundColor(.gray)
          .font(.subheadline)
          .frame(width: 170, alignment: .leading)
      }.frame(width: 170, alignment: .leading)
      Spacer()
      if item.image != nil {
        Image(uiImage: UIImage(data: item.image!)!)
          .renderingMode(.original)
          .resizable()
          .scaledToFit()
          .cornerRadius(10)
          .frame(maxWidth: 170, alignment: .trailing)
          .onTapGesture {
            currentImage = UIImage(data: item.image!)
            imageFullscreen.toggle()
          }
      } else {
        Spacer()
      }
    }
    .sheet(isPresented: $imageFullscreen) {
      VStack {
        HStack {
          Spacer()
          Button("Close") {
            imageFullscreen.toggle()
          }.padding()
        }
        Spacer()
        Image(uiImage: UIImage(data: item.image!)!)
          .resizable()
          .scaledToFit()
        Spacer()
      }
    }
  }
}

// struct ItemList_Previews: PreviewProvider {
//  static var previews: some View {
//    ItemList()
//  }
// }
