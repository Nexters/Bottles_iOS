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
    ListContainerView(
      title: title,
      subTitle: subTitle,
      content: toggle)
  }
}

// MARK: - Views
private extension ToggleListView {
  var toggle: some View {
    BottleToggle(isOn: $isOn)
  }
}
