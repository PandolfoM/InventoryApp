//
//  SplashView.swift
//  InventoryApp
//
//  Created by Matt Pandolfo on 2/6/23.
//

import SwiftUI

struct SplashView: View {
  @State private var isActive = false
  @State private var rotation = 0.0
  @State private var size = 1.0

  var body: some View {
    if isActive {
      ContentView()
        .navigationTitle("Inventory")
    } else {
      VStack {
        VStack {
          Image("logo")
            .resizable()
            .frame(width: 150, height: 150)

          Text("Stockify")
            .font(.title)
            .fontWeight(.medium)
        }
        .scaleEffect(size)
      }
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
          withAnimation(.interpolatingSpring(mass: 0.6, stiffness: 1, damping: 0.8, initialVelocity: 8.5)) {
            self.size = 0.8
          }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
          withAnimation(.easeInOut(duration: 0.5)) {
            self.size = 200.0
          }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
          self.isActive = true
        }
      }
    }
  }
}

struct SplashView_Previews: PreviewProvider {
  static var previews: some View {
    SplashView()
  }
}
