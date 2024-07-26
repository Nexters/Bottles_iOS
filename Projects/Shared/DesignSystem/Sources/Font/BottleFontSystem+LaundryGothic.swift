//
//  BottleFontSystem+LaundryGothic.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/26/24.
//

import SwiftUI

public extension Font.BottleFontSystem {
  enum LaundryGothic: Fontable {
    case title1
  }
}

public extension Font.BottleFontSystem.LaundryGothic {
  var font: Font {
    switch self {
    case .title1:
      return SharedDesignSystemFontFamily.LaundryGothicOTF.bold.swiftUIFont(size: 24)
    }
  }
}
