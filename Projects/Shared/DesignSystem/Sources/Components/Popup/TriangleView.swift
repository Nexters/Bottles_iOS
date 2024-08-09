//
//  TriangleView.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/28/24.
//

import SwiftUI

struct TriangleView: View {
  private let triangleWidth: CGFloat
  private let triangleHeight: CGFloat
  
  init(triangleWidth: CGFloat, triangleHeight: CGFloat) {
    self.triangleWidth = triangleWidth
    self.triangleHeight = triangleHeight
  }
  
  var body: some View {
    TriangleShape(width: triangleWidth, height: triangleHeight)
      .fill(ColorToken.container(.primary).color)
      .overlay(
        TriangleShape(width: triangleWidth, height: triangleHeight)
          .stroke(
            ColorToken.container(.primary).color,
            style: StrokeStyle(lineCap: .round, lineJoin: .round)
          )
      )
  }
}
