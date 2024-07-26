//
//  Color+Extensions.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/26/24.
//

import SwiftUI

public extension Color {
  enum BottleColorSystem: Colorable {
    case primary(Primary)
    case neutral(Neutral)
    case sub(Sub)
    
    public var color: Color {
      switch self {
      case .primary(let primary):
        return primary.color
      case .neutral(let neutral):
        return neutral.color
      case .sub(let sub):
        return sub.color
      }
    }
  }
}
