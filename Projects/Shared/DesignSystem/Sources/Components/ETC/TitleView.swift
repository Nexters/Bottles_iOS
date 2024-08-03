//
//  TitleView.swift
//  DesignSystemExample
//
//  Created by 임현규 on 8/3/24.
//

import SwiftUI

public struct PageInfo {
  var nowPage: Int
  var totalCount: Int
  
  public init(nowPage: Int, totalCount: Int) {
    self.nowPage = nowPage
    self.totalCount = totalCount
  }
}

public struct TitleView: View {
  private let pageInfo: PageInfo?
  private let title: String
  private let caption: String?
  
  public init(
    pageInfo: PageInfo? = nil,
    title: String,
    caption: String? = nil
  ) {
    self.pageInfo = pageInfo
    self.title = title
    self.caption = caption
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      pageIndicator
        .padding(.bottom, .xl)
      
      HStack(spacing: 0) {
        titleText
        Spacer()
      }
      
      HStack(spacing: 0) {
        captionText
          .padding(.top, .sm)
        Spacer()
      }
    }
  }
}

private extension TitleView {
  var titleText: some View {
    WantedSansStyleText(
      title,
      style: .title1,
      color: .primary
    )
    .multilineTextAlignment(.leading)
  }
  
  @ViewBuilder
  var captionText: some View {
    if let caption {
      WantedSansStyleText(
        caption,
        style: .caption,
        color: .tertiary
      )
      .multilineTextAlignment(.leading)
    } else {
      EmptyView()
    }
  }
  
  @ViewBuilder
  var pageIndicator: some View {
    if let pageInfo {
      PageIndicatorView(
        nowNumber: pageInfo.nowPage,
        totalCount: pageInfo.totalCount
      )
    } else {
      EmptyView()
    }
  }
}
