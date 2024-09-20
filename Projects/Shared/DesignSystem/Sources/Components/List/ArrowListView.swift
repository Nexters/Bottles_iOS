//
//  ArrowListView.swift
//  DesignSystemExample
//
//  Created by 임현규 on 9/2/24.
//

import SwiftUI

public struct ArrowListView: View {
  public let title: String
  public let subTitle: String?
  
  public init(
    title: String,
    subTitle: String? = nil
  ) {
    self.title = title
    self.subTitle = subTitle
  }
  
  public var body: some View {
    ListContainerView(
      title: title,
      subTitle: subTitle,
      content: rightArrowImage
    )
  }
}

// MARK: - Views
private extension ArrowListView {
  var rightArrowImage: some View {
    BottleImageView(
      type: .local(
        bottleImageSystem: .icom(.right)
      )
    )
    .foregroundStyle(to: ColorToken.icon(.primary))
    .frame(width: 24)
    .frame(height: 24)
  }
}
