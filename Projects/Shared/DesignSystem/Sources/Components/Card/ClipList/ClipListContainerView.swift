//
//  ClipListContainerView.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 8/2/24.
//

import SwiftUI

public struct ClipListContainerView: View {
  private let clipItemList: [ClipItem]
  
  public init(clipItemList: [ClipItem]) {
    self.clipItemList = clipItemList
  }
  
  public var body: some View {
    VStack(spacing: .xl) {
      ForEach(clipItemList, id: \.self) { clipItem in
        ClipListView(clipItem: clipItem)
      }
    }
    .padding(.horizontal, .md)
    .padding(.vertical, .xl)
    .overlay(
      RoundedRectangle(cornerRadius: BottleRadiusType.xl.value)
        .strokeBorder(
          ColorToken.border(.primary).color,
          lineWidth: 1
        )
    )
  }
}
