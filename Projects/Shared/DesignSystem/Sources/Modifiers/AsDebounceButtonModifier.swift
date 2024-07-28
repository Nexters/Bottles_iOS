//
//  AsDebounceButtonModifier.swift
//  CoreUtil
//
//  Created by JongHoon on 7/27/24.
//

import SwiftUI

private struct AsDebounceButtonModifier: ViewModifier {
  private let action: () -> Void
  
  init(action: @escaping () -> Void) {
    self.action = action
  }
  
  func body(content: Content) -> some View {
    content
      .asButton {
        action()
      }
  }
}

public extension View {
  func asDebounceButton(action: @escaping () -> Void) -> some View {
    modifier(AsDebounceButtonModifier(action: action))
  }
}
