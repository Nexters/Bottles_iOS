//
//  BottleFontSystem+WantedSans.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/26/24.
//

import SwiftUI

public extension Font.BottleFontSystem {
  enum WantedSans: Fontable {
    case title1
    case title2
    case subTitle1
    case subTitle2
    case body
    case caption
  }
}

public extension Font.BottleFontSystem.WantedSans {
  var font: Font {
    switch self {
    case .title1:
      return SharedDesignSystemFontFamily.WantedSans.bold.swiftUIFont(size: 24)
    case .title2:
      return SharedDesignSystemFontFamily.WantedSans.bold.swiftUIFont(size: 20)
    case .subTitle1:
      return SharedDesignSystemFontFamily.WantedSans.semiBold.swiftUIFont(size: 16)
    case .subTitle2:
      return SharedDesignSystemFontFamily.WantedSans.semiBold.swiftUIFont(size: 14)
    case .body:
      return SharedDesignSystemFontFamily.WantedSans.medium.swiftUIFont(size: 14)
    case .caption:
      return SharedDesignSystemFontFamily.WantedSans.bold.swiftUIFont(size: 12)
    }
  }
}

extension Font.BottleFontSystem.WantedSans: CaseIterable { }
