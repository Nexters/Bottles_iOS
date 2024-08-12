//
//  EndEditingModifier.swift
//  DesignSystemExample
//
//  Created by 임현규 on 8/12/24.
//

import Foundation
import SwiftUI

private struct OnTapEndEditingModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .contentShape(Rectangle())
      .onTapGesture {
        content.endTextEditing()
      }
  }
}

// MARK: - public extension
public extension View {
  func onTapEndEditing() -> some View {
    modifier(OnTapEndEditingModifier())
  }
}

// MARK: - private extension
private extension View {
  func endTextEditing() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
