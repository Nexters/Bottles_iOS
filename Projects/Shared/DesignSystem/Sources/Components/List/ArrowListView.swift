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
    HStack(spacing: 0) {
      VStack(alignment: .leading, spacing: 8) {
        titleView
        subTitleView
      }
      Spacer()
      rightArrowImage
    }
  }
}

// MARK: - Views
private extension ArrowListView {
  var titleView: some View {
    WantedSansStyleText(
      title,
      style: .subTitle2,
      color: .secondary
    )
  }
  
  @ViewBuilder
  var subTitleView: some View {
    if let subTitle = subTitle {
      WantedSansStyleText(
        subTitle,
        style: .caption,
        color: .tertiary
      )
    } else {
      EmptyView()
    }
  }
  
  var rightArrowImage: some View {
    BottleImageView(
      type: .local(
        bottleImageSystem: .icom(.right)
      )
    )
    .foregroundStyle(to: ColorToken.icon(.primary))
  }
}
