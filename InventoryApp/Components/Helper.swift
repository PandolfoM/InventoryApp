//
//  Helper.swift
//  InventoryApp
//
//  Created by Matt Pandolfo on 2/10/23.
//
import SwiftUI

extension Date {
  func timeAgo() -> Text {
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .full
    formatter.allowedUnits = [.year, .month, .day, .hour, .minute]
    formatter.zeroFormattingBehavior = .dropAll
    formatter.maximumUnitCount = 1
    let final = String(format: formatter.string(from: self, to: Date()) ?? "", locale: .current)
    if final == "0 minutes" {
      return Text("Now")
    } else {
      return Text("\(final) ago")
    }
  }
}
