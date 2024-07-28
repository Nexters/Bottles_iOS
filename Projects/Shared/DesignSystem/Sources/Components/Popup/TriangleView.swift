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
    GeometryReader { geometry in
      let xPos = geometry.size.width / 2 - triangleWidth / 2, yPos = geometry.size.height
      Path { path in
        path.move(to: CGPoint(x: xPos, y: yPos))
        path.addLine(to: CGPoint(x: xPos + triangleWidth, y: yPos))
        path.addLine(to: CGPoint(x: xPos + triangleWidth / 2, y: yPos + triangleHeight))
        path.addLine(to: CGPoint(x: xPos, y: yPos))
      }
      .stroke(ColorToken.border(.primary).color,
              style: StrokeStyle(lineCap: .round, lineJoin: .round))
      .fill(ColorToken.border(.primary).color)
    }
  }
}
