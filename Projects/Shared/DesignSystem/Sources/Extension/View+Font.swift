//
//  View+Font.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/26/24.
//

import SwiftUI

public extension View {
  func font(to fontType: Font.BottleFontSystem) -> some View {
    self.font(fontType.font)
  }
}
