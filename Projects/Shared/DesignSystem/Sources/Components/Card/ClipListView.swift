//
//  ClipListView.swift
//  DesignSystemExample
//
//  Created by 임현규 on 8/2/24.
//

import SwiftUI

public struct ClipListView: View {
  private let clipItem: ClipItem
  
  public init(clipItem: ClipItem) {
    self.clipItem = clipItem
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
      clipItem.title,
      style: .subTitle2,
      color: .tertiary
    )
  }
  
  var clipList: some View {
    ClipListLayout() {
      ForEach(clipItem.list, id: \.self) { item in
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

