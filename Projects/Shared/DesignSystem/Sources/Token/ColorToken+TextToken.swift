//
//  ColorToken+TextToken.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/27/24.
//

import SwiftUI

public extension ColorToken {
  enum TextToken: Colorable {
    case primary
    case secondary
    case tertiary
    case quaternary
    case quinary
    case senary
    case enablePrimary
    case enableSecondary
    case enableTertiary
    case enableQuaternary
    case disablePrimary
    case disableSecondary
    case pressed
    case selectPrimary
    case selectSecondary
    case focusePrimary
    case focuseSecondary
    case activePrimary
    case activeSecondary
    case errorPrimary
    case errorSecondary
    case errorTertiary
  }
}

public extension ColorToken.TextToken {
  var color: Color {
    switch self {
    case .primary:
      return Color.BottleColorSystem.sub(.black).color

    case .secondary:
      return Color.BottleColorSystem.neutral(.neutral900).color
    case .tertiary:
      return Color.BottleColorSystem.neutral(.neutral600).color

    case .quaternary:
      return Color.BottleColorSystem.sub(.white).color

    case .quinary:
      return Color.BottleColorSystem.primary(.purple500).color

    case .senary:
      return Color.BottleColorSystem.primary(.purple300).color

    case .enablePrimary:
      return Color.BottleColorSystem.sub(.white).color

    case .enableSecondary:
      return Color.BottleColorSystem.neutral(.neutral900).color

    case .enableTertiary:
      return Color.BottleColorSystem.neutral(.neutral400).color

    case .enableQuaternary:
      return Color.BottleColorSystem.neutral(.neutral600).color

    case .disablePrimary:
      return Color.BottleColorSystem.sub(.white).color

    case .disableSecondary:
      return Color.BottleColorSystem.neutral(.neutral400).color

    case .pressed:
      return Color.BottleColorSystem.sub(.white).color

    case .selectPrimary:
      return Color.BottleColorSystem.primary(.purple500).color

    case .selectSecondary:
      return Color.BottleColorSystem.sub(.black).color

    case .focusePrimary:
      return Color.BottleColorSystem.neutral(.neutral900).color

    case .focuseSecondary:
      return Color.BottleColorSystem.neutral(.neutral600).color

    case .activePrimary:
      return Color.BottleColorSystem.neutral(.neutral900).color

    case .activeSecondary:
      return Color.BottleColorSystem.neutral(.neutral600).color

    case .errorPrimary:
      return Color.BottleColorSystem.sub(.red).color

    case .errorSecondary:
      return Color.BottleColorSystem.neutral(.neutral900).color

    case .errorTertiary:
      return Color.BottleColorSystem.neutral(.neutral600).color
    }
  }
}
