//
//  LettetCardView.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 8/7/24.
//

import SwiftUI

public struct LettetCardView: View {
  private let title: String
  private let letterContent: String
  
  public init(title: String, letterContent: String) {
    self.title = title
    self.letterContent = letterContent
  }
  
  public var body: some View {
    VStack(spacing: .xl) {
      titleText
      letterText
    }
    .padding(.horizontal, .md)
    .padding(.vertical, .xl)
    .overlay(roundedRectangle)
  }
}

// MARK: - Views
private extension LettetCardView {
  var roundedRectangle: some View {
    RoundedRectangle(cornerRadius: BottleRadiusType.xl.value)
      .strokeBorder(
        ColorToken.border(.primary).color,
        lineWidth: 1
      )
  }
  
  var titleText: some View {
    HStack(spacing: 0) {
      WantedSansStyleText(
        "\(title)",
        style: .subTitle1,
        color: .primary
      )
      Spacer()
    }
  }
  
  var letterText: some View {
    HStack(spacing: 0) {
      WantedSansStyleText(
        letterContent,
        style: .body,
        color: .secondary
      )
      .multilineTextAlignment(.leading)
      
      Spacer()
    }
    .padding(.md)
    .lineSpacing(5)
    .background {
      RoundedRectangle(cornerRadius: BottleRadiusType.xs.value)
        .fill(ColorToken.onContainer(.primary).color)
    }
  }
}
