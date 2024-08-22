//
//  View+RoundedCorner.swift
//  DesignSystemExample
//
//  Created by 임현규 on 8/8/24.
//

import SwiftUI

struct RoundedCorner: Shape {
  public var radius: CGFloat = .infinity
  public var corners: UIRectCorner = .allCorners
  
  init(
    radius: BottleRadiusType,
    corners: UIRectCorner
  ) {
    self.radius = radius.value
    self.corners = corners
  }
  
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(
      roundedRect: rect,
      byRoundingCorners: corners,
      cornerRadii: CGSize(width: radius, height: radius)
    )
    return Path(path.cgPath)
  }
}

extension View {
  public func cornerRadius(_ radius: BottleRadiusType, corenrs: UIRectCorner) -> some View {
    clipShape(RoundedCorner(radius: radius, corners: corenrs))
  }
}
