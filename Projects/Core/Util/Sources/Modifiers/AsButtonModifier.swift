//
//  AsButtonModifier.swift
//  CoreUtil
//
//  Created by JongHoon on 7/27/24.
//

import SwiftUI

private struct AsButtonModifier: ViewModifier {
  private let action: () -> Void
  
  init(action: @escaping () -> Void) {
    self.action = action
  }
  
  func body(content: Content) -> some View {
    Button(action: action) {
      content
    }
  }
}

public extension View {
  func asButton(action: @escaping () -> Void) -> some View {
    modifier(AsButtonModifier(action: action))
  }
}
