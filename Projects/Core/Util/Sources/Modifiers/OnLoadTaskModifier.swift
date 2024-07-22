//
//  OnLoadTaskModifier.swift
//  CoreUtil
//
//  Created by JongHoon on 7/21/24.
//

import SwiftUI

import SwiftUI

private struct OnLoadTaskModifier: ViewModifier {
  @State private var didLoad = false
  private let action: () -> Void
  
  init(perform action: @escaping () -> Void) {
    self.action = action
  }
  
  func body(content: Content) -> some View {
    content.task {
      if didLoad == false {
        didLoad = true
        action()
      }
    }
  }
}

public extension View {
  func onLoadTask(perform action: @escaping () -> Void) -> some View {
    modifier(OnLoadTaskModifier(perform: action))
  }
}
