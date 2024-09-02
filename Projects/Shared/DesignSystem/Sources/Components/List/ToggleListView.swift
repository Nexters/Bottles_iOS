//
//  ToggleListView.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 9/2/24.
//

import SwiftUI

public struct ToggleListView: View {
  private let title: String
  private let subTitle: String?
  @Binding private var isOn: Bool
  
  public init(
    title: String,
    subTitle: String? = nil,
    isOn: Binding<Bool>
  ) {
    self.title = title
    self.subTitle = subTitle
    self._isOn = isOn
  }
  
  public var body: some View {
    HStack(spacing: 0) {
      VStack(alignment: .leading, spacing: 8) {
        titleView
        subTitleView
      }
      Spacer()
      toggle
    }
  }
}

// MARK: - Views
private extension ToggleListView {
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
  
  var toggle: some View {
    BottleToggle(isOn: $isOn)
  }
}
