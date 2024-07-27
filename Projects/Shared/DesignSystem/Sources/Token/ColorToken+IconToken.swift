//
//  ColorToken+IconToken.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/27/24.
//

import SwiftUI

public extension ColorToken {
  enum IconToken: Colorable {
    case primary
    case secondary
    case disabled
    case update
  }
}
  
public extension ColorToken.IconToken {
  var color: Color {
    switch self {
    case .primary:
      return Color.BottleColorSystem.neutral(.neutral500).color

    case .secondary:
      return Color.BottleColorSystem.neutral(.neutral200).color

    case .disabled:
      return Color.BottleColorSystem.neutral(.neutral200).color

    case .update:
      return Color.BottleColorSystem.sub(.red).color

    }
  }
}
