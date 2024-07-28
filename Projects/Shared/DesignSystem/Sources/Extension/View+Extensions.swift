//
//  View+Extensions.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/26/24.
//

import SwiftUI

public extension View {

  // MARK: - colorToken
  func background(to colorToken: Colorable) -> some View {
    self.background(colorToken.color)
  }
  
  func tint(to colorToken: Colorable) -> some View {
    self.tint(colorToken.color)
  }
  
  func foregroundStyle(to colorToken: Colorable) -> some View {
    self.foregroundStyle(colorToken.color)
  }
  
  func colorMultiply(to colorToken: Colorable) -> some View {
    self.colorMultiply(colorToken.color)
  }
}
