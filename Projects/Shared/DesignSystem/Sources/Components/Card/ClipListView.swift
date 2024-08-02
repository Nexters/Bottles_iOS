//
//  ClipListView.swift
//  DesignSystemExample
//
//  Created by 임현규 on 8/2/24.
//

import SwiftUI

public struct ClipListView: View {
  private let title: String
  private let tagList: [String]
  
  public init(title: String, tagList: [String]) {
    self.title = title
    self.tagList = tagList
  }
  
  public var body: some View {
    VStack(spacing: .sm) {
      HStack(spacing: 0) {
        titleText
        Spacer()
      }
      clipList
    }
  }
}

private extension ClipListView {
  var titleText: some View {
    WantedSansStyleText(
      title,
      style: .subTitle2,
      color: .tertiary
    )
  }
  
  var clipList: some View {
    ClipListLayout() {
      ForEach(tagList, id: \.self) { item in
        WantedSansStyleText(
          item,
          style: .body,
          color: .secondary
        )
        .frame(height: 36)
        .padding(.horizontal, .sm)
        .overlay(
          RoundedRectangle(cornerRadius: BottleRadiusType.xs.value)
            .strokeBorder(
              ColorToken.border(.primary).color,
              lineWidth: 1
            )
        )
      }
    }
  }
}

