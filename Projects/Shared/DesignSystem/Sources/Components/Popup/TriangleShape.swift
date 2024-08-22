//
//  TriangleShape.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 8/3/24.
//

import SwiftUI

struct TriangleShape: Shape {
  private let width: CGFloat
  private let height: CGFloat
  
  init(width: CGFloat, height: CGFloat) {
    self.width = width
    self.height = height
  }
  
  func path(in rect: CGRect) -> Path {
    let xPos = rect.midX - width / 2
    let yPos = rect.maxY
    var path = Path()
    path.move(to: CGPoint(x: xPos, y: yPos))
    path.addLine(to: CGPoint(x: xPos + width, y: yPos))
    path.addLine(to: CGPoint(x: xPos + width / 2, y: yPos + height))
    path.addLine(to: CGPoint(x: xPos, y: yPos))
    path.closeSubpath()
    return path
  }
}
