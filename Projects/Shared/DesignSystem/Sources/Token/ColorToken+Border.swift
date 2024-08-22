//
//  ColorToken+Border.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/27/24.
//

import SwiftUI

public extension ColorToken {
  enum Border: Colorable {
    case primary
    case secondary
    case enabled
    case disabled
    case selected
    case focused
    case active
    case error
  }
}

public extension ColorToken.Border {
  var color: Color {
    switch self {
    case .primary:
      return Color.BottleColorSystem.neutral(.neutral300).color
    case .secondary:
      return Color.BottleColorSystem.neutral(.neutral200).color

    case .enabled:
      return Color.BottleColorSystem.neutral(.neutral300).color

    case .disabled:
      return Color.BottleColorSystem.neutral(.neutral300).color

    case .selected:
      return Color.BottleColorSystem.primary(.purple500).color

    case .focused:
      return Color.BottleColorSystem.neutral(.neutral300).color

    case .active:
      return Color.BottleColorSystem.neutral(.neutral300).color

    case .error:
      return Color.BottleColorSystem.sub(.red).color
    }
  }
}
