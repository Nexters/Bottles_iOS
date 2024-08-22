//
//  ColorToken+OnContainer.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/27/24.
//

import SwiftUI

public extension ColorToken {
  enum OnContainer: Colorable {
    case primary
    case secondary
    case enablePrimary
    case enableSecondary
    case disable
    case focuse
    case active
    case error
  }
}

public extension ColorToken.OnContainer {
  var color: Color {
    switch self {
    case .primary:
      return Color.BottleColorSystem.primary(.purple100).color
    case .secondary:
      return Color.BottleColorSystem.neutral(.neutral100).color

    case .enablePrimary:
      return Color.BottleColorSystem.neutral(.neutral100).color

    case .enableSecondary:
      return Color.BottleColorSystem.sub(.white).color

    case .disable:
      return Color.BottleColorSystem.neutral(.neutral100).color

    case .focuse:
      return Color.BottleColorSystem.neutral(.neutral100).color

    case .active:
      return Color.BottleColorSystem.neutral(.neutral100).color

    case .error:
      return Color.BottleColorSystem.neutral(.neutral100).color
    }
  }
}
