//
//  ColorToken+Container.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/27/24.
//

import SwiftUI

public extension ColorToken {
  enum Container: Colorable {
    case primary
    case secondary
    case tertiary
    case enablePrimary
    case enableSecondary
    case disablePrimary
    case disableSecondary
    case pressed
    case selected
    case focusePrimary
    case focuseSecondary
    case Active
    case erroPrimary
    case errorSecondary
    case kakao
  }
}

public extension ColorToken.Container {
  var color: Color {
    switch self {
    case .primary:
      return Color.BottleColorSystem.sub(.white).color
    case .secondary:
      return Color.BottleColorSystem.primary(.purple100).color

    case .tertiary:
      return Color.BottleColorSystem.neutral(.neutral600).color

    case .enablePrimary:
      return Color.BottleColorSystem.sub(.white).color

    case .enableSecondary:
      return Color.BottleColorSystem.primary(.purple400).color

    case .disablePrimary:
      return Color.BottleColorSystem.sub(.white).color

    case .disableSecondary:
      return Color.BottleColorSystem.neutral(.neutral400).color

    case .pressed:
      return Color.BottleColorSystem.primary(.purple500).color

    case .selected:
      return Color.BottleColorSystem.primary(.purple100).color

    case .focusePrimary:
      return Color.BottleColorSystem.neutral(.neutral100).color

    case .focuseSecondary:
      return Color.BottleColorSystem.sub(.white).color

    case .Active:
      return Color.BottleColorSystem.sub(.white).color

    case .erroPrimary:
      return Color.BottleColorSystem.neutral(.neutral100).color

    case .errorSecondary:
      return Color.BottleColorSystem.sub(.white).color
      
    case .kakao:
      return Color.BottleColorSystem.sub(.kakao).color
    }
  }
}
