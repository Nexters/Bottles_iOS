//
//  BottleColorSystem+Primary.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/26/24.
//

import SwiftUI

extension Color.BottleColorSystem {
  enum Primary: Colorable {
    case purple100
    case purple200
    case purple300
    case purple400
    case purple500
  }
}

extension Color.BottleColorSystem.Primary {
  var color: Color {
    switch self {
    case .purple100:
      return Color(asset: SharedDesignSystemAsset.Colors.primaryPurple100)
    case .purple200:
      return Color(asset: SharedDesignSystemAsset.Colors.primaryPurple200)
    case .purple300:
      return Color(asset: SharedDesignSystemAsset.Colors.primaryPurple300)
    case .purple400:
      return Color(asset: SharedDesignSystemAsset.Colors.primaryPurple400)
    case .purple500:
      return Color(asset: SharedDesignSystemAsset.Colors.primaryPurple500)
    }
  }
}
