//
//  ToastItemView.swift
//  DesignSystemExample
//
//  Created by JongHoon on 8/4/24.
//

import SwiftUI

struct ToastItemView: View {
  @State private var animateIn: Bool = false
  @State private var animateOut: Bool = false
  private let size: CGSize
  private let item: ToastItem
  
  init(
    size: CGSize,
    item: ToastItem
  ) {
    self.size = size
    self.item = item
  }
  
  var body: some View {
    WantedSansStyleText(
      item.message,
      style: .body,
      color: .quaternary
    )
    .padding(.horizontal, 12.0)
    .padding(.vertical, 7.5)
    .background(to: ColorToken.container(.tertiary))
    .clipShape(RoundedRectangle(cornerRadius: BottleRadiusType.sm.value))
    .offset(y: animateIn ? 0 : 152.0)
    .offset(y: !animateOut ? 0 : 152.0)
    .task {
      guard !animateIn else { return }
      withAnimation(.snappy) {
        animateIn = true
      }
      
      try? await Task.sleep(nanoseconds: UInt64(item.durationSecond * 1000_000_000))
      
      removeToast()
    }
  }
  
  func removeToast() {
    guard !animateOut else { return }
    withAnimation {
      animateOut = true
    }
  }
}
