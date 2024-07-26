//
//  BottleColorSystem+Neutral.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/26/24.
//

import SwiftUI

public extension Color.BottleColorSystem {
  enum Neutral: Colorable {
    case neutral100
    case neutral200
    case neutral300
    case neutral400
    case neutral500
    case neutral600
    case neutral700
    case neutral800
    case neutral900
  }
}

public extension Color.BottleColorSystem.Neutral {
  var color: Color {
    switch self {
    case .neutral100:
      Color(asset: SharedDesignSystemAsset.neutral100)
    case .neutral200:
      Color(asset: SharedDesignSystemAsset.neutral200)
    case .neutral300:
      Color(asset: SharedDesignSystemAsset.neutral300)
    case .neutral400:
      Color(asset: SharedDesignSystemAsset.neutral400)
    case .neutral500:
      Color(asset: SharedDesignSystemAsset.neutral500)
    case .neutral600:
      Color(asset: SharedDesignSystemAsset.neutral600)
    case .neutral700:
      Color(asset: SharedDesignSystemAsset.neutral700)
    case .neutral800:
      Color(asset: SharedDesignSystemAsset.neutral800)
    case .neutral900:
      Color(asset: SharedDesignSystemAsset.neutral900)
    }
  }
}
