//
//  ColorToken+Background.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/27/24.
//

import SwiftUI

public extension ColorToken {
  enum Background: Colorable {
    case primary
    case secondary
    case tertiary
  }
}

public extension ColorToken.Background {
  var color: Color {
    switch self {
    case .primary:
      return Color.BottleColorSystem.sub(.gradient).color
    case .secondary:
      return Color.BottleColorSystem.sub(.white).color
    case .tertiary:
      return Color.BottleColorSystem.sub(.gradient).color
    }
  }
}
