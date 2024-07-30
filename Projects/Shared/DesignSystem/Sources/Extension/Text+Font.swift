//
//  Text+Font.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/28/24.
//

import SwiftUI

public extension Text {
  func font(to fontType: Font.BottleFontSystem) -> Text {
    self.font(fontType.font)
  }
}
