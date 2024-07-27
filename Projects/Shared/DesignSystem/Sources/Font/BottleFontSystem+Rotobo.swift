//
//  BottleFontSystem+Rotobo.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/26/24.
//

import SwiftUI

public extension Font.BottleFontSystem {
  enum Roboto: Fontable {
    case kakao
  }
}

public extension Font.BottleFontSystem.Roboto {
  var font: Font {
    switch self {
    case .kakao:
      return SharedDesignSystemFontFamily.Roboto.medium.swiftUIFont(size: 14)
    }
  }
}
