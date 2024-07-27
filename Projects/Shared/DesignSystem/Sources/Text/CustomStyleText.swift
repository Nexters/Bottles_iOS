//
//  CustomStyleText.swift
//  SharedDesignSystem
//
//  Created by JongHoon on 7/27/24.
//

import SwiftUI

public struct CustomStyleText<F: Fontable>: View {
  private let content: String
  private let style: F
  private let color: ColorToken.TextToken
  private var font: Font {
    style.font
  }
  
  public init(
    _ content: String,
    style: F,
    color: ColorToken.TextToken
  ) {
    self.content = content
    self.style = style
    self.color = color
  }
  
  public var body: some View {
    Text(content)
      .font(font)
      .foregroundStyle(to: .text(color))
  }
}
