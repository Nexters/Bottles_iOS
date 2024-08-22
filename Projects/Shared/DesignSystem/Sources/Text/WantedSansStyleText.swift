//
//  WantedSansStyleText.swift
//  SharedDesignSystem
//
//  Created by JongHoon on 7/27/24.
//

import SwiftUI

public struct WantedSansStyleText: View {
  private let content: String
  private let style: Font.BottleFontSystem.WantedSans
  private let color: ColorToken.TextToken
  private var font: Font {
    style.font
  }
  
  public init(
    _ content: String,
    style: Font.BottleFontSystem.WantedSans,
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
