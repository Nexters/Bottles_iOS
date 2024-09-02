//
//  AsThrottleButtonModifier.swift
//  CoreUtil
//
//  Created by JongHoon on 7/27/24.
//

import SwiftUI

private struct AsThrottleButtonModifier: ViewModifier {
  private let action: () -> Void
  private let delay: TimeInterval
  @State private var isThrottling: Bool = false
  
  init(delay: TimeInterval, action: @escaping () -> Void) {
    self.delay = delay
    self.action = action
  }
  
  func body(content: Content) -> some View {
    content
      .asButton {
        if !isThrottling {
          action()
          isThrottling = true
          DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
            isThrottling = false
          }
        }
      }
  }
}

public extension View {
  func asThrottleButton(delay: TimeInterval = 0.5, action: @escaping () -> Void) -> some View {
    modifier(AsThrottleButtonModifier(delay: delay, action: action))
  }
}
