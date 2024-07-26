//
//  BottleColorSystem+Sub.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/26/24.
//

import SwiftUI

public extension Color.BottleColorSystem {
  enum Sub: Colorable {
    case black
    case gradient
    case red
    case white
  }
}

public extension Color.BottleColorSystem.Sub {
  var color: Color {
    switch self {
    case .black:
      return Color(asset: SharedDesignSystemAsset.black100)
    case .gradient:
      return Color(asset: SharedDesignSystemAsset.gradient)
    case .red:
      return Color(asset: SharedDesignSystemAsset.red)
    case .white:
      return Color(asset: SharedDesignSystemAsset.white100)
    }
  }
}
