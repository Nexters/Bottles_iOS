//
//  OnLoadModifier.swift
//  CoreUtil
//
//  Created by JongHoon on 7/21/24.
//

import SwiftUI

private struct OnLoadModifier: ViewModifier {
  @State private var didLoad = false
  private let action: () -> Void
  
  init(perform action: @escaping () -> Void) {
    self.action = action
  }
  
  func body(content: Content) -> some View {
    content.onAppear {
      if didLoad == false {
        didLoad = true
        action()
      }
    }
  }
}

public extension View {
  func onLoad(perform action: @escaping () -> Void) -> some View {
    modifier(OnLoadModifier(perform: action))
  }
}
