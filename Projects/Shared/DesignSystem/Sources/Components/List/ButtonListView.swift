//
//  ButtonListView.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 9/2/24.
//

import SwiftUI

public struct ButtonListView: View {
  private let title: String
  private let subTitle: String?
  private let buttonTitle: String
  private let isShowButton: Bool
  private let action: () -> Void
  
  public init(
    title: String,
    subTitle: String? = nil,
    buttonTitle: String,
    isShowButton: Bool = true,
    action: @escaping () -> Void
  ) {
    self.title = title
    self.subTitle = subTitle
    self.buttonTitle = buttonTitle
    self.isShowButton = isShowButton
    self.action = action
  }
  
  public var body: some View {
    ListContainerView(
      title: title,
      subTitle: subTitle,
      content: button
    )
  }
}

// MARK: - Views
public extension ButtonListView {
  @ViewBuilder
  var button: some View {
    if isShowButton {
      OutlinedStyleButton(
        .small(contentType: .text),
        title: buttonTitle,
        buttonType: .throttle,
        action: action
      )
    } else {
      EmptyView()
    }
  }
}
