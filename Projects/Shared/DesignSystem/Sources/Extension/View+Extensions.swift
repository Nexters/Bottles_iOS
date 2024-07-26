//
//  View+Extensions.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/26/24.
//

import SwiftUI

public extension View {
  
  // MARK: - ColorType
  
  func foregroundStyle(to colorType: Color.BottleColorSystem) -> some View {
    self.foregroundStyle(colorType.color)
  }
  
  func background(_ colorType: Color.BottleColorSystem) -> some View {
    self.background(colorType.color)
  }
  
  func tint(_ colorType: Color.BottleColorSystem) -> some View {
    self.tint(colorType.color)
  }
}
