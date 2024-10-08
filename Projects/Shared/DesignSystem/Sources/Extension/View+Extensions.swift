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

// MARK: - public Methods
extension View {
  public func makeLeftBubbleText(text: String) -> some View {
    HStack(spacing: 0) {
      PingPongBubble(
        content: text,
        isRight: false
      )
      Spacer()
    }
  }
  
  public func makeRightBubbleText(text: String) -> some View {
    HStack(spacing: 0) {
      Spacer()
      PingPongBubble(
        content: text,
        isRight: true
      )
    }
  }
}

// MARK: - View Layout

extension View {
  public func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
    background(
      GeometryReader { geometry in
        Color.clear
          .preference(key: CGSizePreferenceKey.self, value: geometry.size)
      }
    )
    .onPreferenceChange(CGSizePreferenceKey.self, perform: onChange)
  }
}
