//
//  AsThrottleButtonModifier.swift
//  CoreUtil
//
//  Created by JongHoon on 7/27/24.
//

import SwiftUI

private struct AsThrottleButtonModifier: ViewModifier {
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
  func asThrottleButton(action: @escaping () -> Void) -> some View {
    modifier(AsThrottleButtonModifier(action: action))
  }
}
