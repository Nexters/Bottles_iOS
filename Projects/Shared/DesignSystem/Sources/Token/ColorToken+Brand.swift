//
//  ColorToken+Brand.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/27/24.
//

import SwiftUI

public extension ColorToken {
  enum Brand: Colorable {
    case primary
    case secondary
    case tertiary
    case quaternary
  }
}

public extension ColorToken.Brand {
  var color: Color {
    switch self {
    case .primary:
      return Color.BottleColorSystem.primary(.purple400).color
    case .secondary:
      return Color.BottleColorSystem.primary(.purple500).color
    case .tertiary:
      return Color.BottleColorSystem.primary(.purple300).color
    case .quaternary:
      return Color.BottleColorSystem.primary(.purple100).color
    }
  }
}
