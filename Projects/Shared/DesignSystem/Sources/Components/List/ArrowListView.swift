//
//  ArrowListView.swift
//  DesignSystemExample
//
//  Created by 임현규 on 9/2/24.
//

import SwiftUI

public struct ArrowListView: View {
  private let title: String
  private let subTitle: String?
  private let action: () -> Void
  
  public init(
    title: String,
    subTitle: String? = nil,
    action: @escaping () -> Void
  ) {
    self.title = title
    self.subTitle = subTitle
    self.action = action
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
    .asThrottleButton(action: action)
  }
}
