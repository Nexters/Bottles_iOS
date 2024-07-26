//
//  BottleColorSystem+Primary.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/26/24.
//

import SwiftUI

public extension Color.BottleColorSystem {
  enum Primary: Colorable {
    case purple100
    case purple200
    case purple300
    case purple400
    case purple500
  }
}

public extension Color.BottleColorSystem.Primary {
  var color: Color {
    switch self {
    case .purple100:
      return Color(asset: SharedDesignSystemAsset.primaryPurple100)
    case .purple200:
      return Color(asset: SharedDesignSystemAsset.primaryPurple200)
    case .purple300:
      return Color(asset: SharedDesignSystemAsset.primaryPurple300)
    case .purple400:
      return Color(asset: SharedDesignSystemAsset.primaryPurple400)
    case .purple500:
      return Color(asset: SharedDesignSystemAsset.primaryPurple500)
    }
  }
}
