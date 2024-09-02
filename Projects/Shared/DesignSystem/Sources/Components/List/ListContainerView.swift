//
//  ListContainerView.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 9/2/24.
//

import SwiftUI

struct ListContainerView<Content: View>: View {
  private let title: String
  private let subTitle: String?
  private let content: Content
  
  init(
    title: String,
    subTitle: String? = nil,
    content: Content
  ) {
    self.title = title
    self.subTitle = subTitle
    self.content = content
  }
  
  var body: some View {
    HStack(spacing: 0) {
      VStack(alignment: .leading, spacing: 8) {
        titleView
        subTitleView
      }
      Spacer()
      content
    }
  }
}

// MARK: - Views
private extension ListContainerView {
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
}
