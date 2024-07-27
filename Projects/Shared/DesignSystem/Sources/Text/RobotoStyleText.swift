//
//  RobotoStyleText.swift
//  SharedDesignSystem
//
//  Created by JongHoon on 7/27/24.
//

import SwiftUI

public struct RobotoStyleText: View {
  private let content: String
  private let style: Font.BottleFontSystem.Roboto
  private let color: ColorToken.TextToken
  private var font: Font {
    style.font
  }
  
  public init(
    _ content: String,
    style: Font.BottleFontSystem.Roboto,
    color: ColorToken.TextToken
  ) {
    self.content = content
    self.style = style
    self.color = color
  }
  
  public var body: some View {
    CustomStyleText(
      content,
      style: style,
      color: color
    )
  }
}
