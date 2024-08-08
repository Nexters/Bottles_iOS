//
//  PingPongBubble.swift
//  DesignSystemExample
//
//  Created by 임현규 on 8/8/24.
//

import SwiftUI

public struct PingPongBubble: View {
  private let content: String
  private let isRight: Bool
  
  public init(
    content: String,
    isRight: Bool
  ) {
    self.content = content
    self.isRight = isRight
  }
  
  public var body: some View {
    text
  }
}

// MARK: - Views
private extension PingPongBubble {
  var roundedRectangle: some View {
    Rectangle()
      .fill(backgroundColor)
      .cornerRadius(.xs, corenrs: rectCorner)
  }
  
  var text: some View {
    WantedSansStyleText(
      content,
      style: .body,
      color: .secondary
    )
    .lineSpacing(5)
    .padding(.horizontal, .md)
    .padding(.vertical, .sm)
    .background {
      roundedRectangle
    }
  }
  
  var backgroundColor: Color {
    return isRight ? ColorToken.onContainer(.primary).color : ColorToken.onContainer(.secondary).color
  }
  
  var rectCorner: UIRectCorner {
    return isRight ? [.topLeft, .topRight, .bottomLeft] : [.topLeft, .topRight, .bottomRight]
  }
}
