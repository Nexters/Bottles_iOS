//
//  CountLabel.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/30/24.
//

import SwiftUI

public struct CountLabel: View {
  private let radius: CGFloat = 24
  private let text: String
  
  public init(text: String) {
    self.text = text
  }
  
  public var body: some View {
    WantedSansStyleText(
      text,
      style: .body,
      color: .quaternary
    )
    .padding(4)
    .frame(minWidth: radius)
    .frame(height: radius)
    .frame(maxWidth: nil)
    .background(to: ColorToken.icon(.update))
    .clipShape(RoundedRectangle(cornerRadius: radius / 2))
  }
}
