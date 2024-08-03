//
//  BottleColorSystem+Sub.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/26/24.
//

import SwiftUI

extension Color.BottleColorSystem {
  enum Sub: Colorable {
    case black
    case gradient
    case red
    case white
  }
}

extension Color.BottleColorSystem.Sub {
  var color: Color {
    switch self {
    case .black:
      return Color(asset: SharedDesignSystemAsset.Colors.black100)
    case .gradient:
      return Color(asset: SharedDesignSystemAsset.Colors.gradient)
    case .red:
      return Color(asset: SharedDesignSystemAsset.Colors.red)
    case .white:
      return Color(asset: SharedDesignSystemAsset.Colors.white100)
    }
  }
}
