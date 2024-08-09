//
//  PingPongContainerView.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 8/9/24.
//

import SwiftUI

public struct PingPongContainer<Content: View>: View {
  @State private var isHidden: Bool = false
  
  private let isActive: Bool
  private var pingpongTitle: String
  private var content: Content
  
  public init(
    isActive: Bool,
    pingpongTitle: String,
    @ViewBuilder content: () -> Content
  ) {
    self.isActive = isActive
    self.pingpongTitle = pingpongTitle
    self.content = content()
  }
  public var body: some View {
    VStack(spacing: 0) {
      title
      
      if isHidden {
        Divider()
          .padding(.horizontal, .md)
        content
          .transition(.move(edge: .top))
      }
    }
    .clipped()
    .background(.white)
    .overlay(
      roundedRectangle
    )
  }
}

// MARK: - Views
private extension PingPongContainer {
  var roundedRectangle: some View {
    RoundedRectangle(cornerRadius: BottleRadiusType.xl.value)
      .strokeBorder(
        ColorToken.border(.primary).color,
        lineWidth: 1
      )
  }
  
  var title: some View {
    HStack(spacing: 0) {
      WantedSansStyleText(
        pingpongTitle,
        style: .subTitle1,
        color: titleColor
      )
      
      Spacer()
      
      LocalImageView(.icom(.up))
        .rotationEffect(.degrees((isHidden ? -180 : 0)))
        .asButton {
          withAnimation(.snappy) {
            isHidden.toggle()
          }
        }
        .tint(to: arrowButtonColor)
        .disabled(!isActive)
    }
    .padding(.horizontal, .md)
    .frame(height: 72)
    .background(.white)
    .zIndex(2)
  }
  
  var titleColor: ColorToken.TextToken {
    isActive ? .focusePrimary : .disableSecondary
  }
  
  var arrowButtonColor: ColorToken.IconToken {
    isActive ? .primary : .disabled
  }
}
