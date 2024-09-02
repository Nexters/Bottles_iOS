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
  private let action: () -> Void
  
  public init(
    title: String,
    subTitle: String? = nil,
    buttonTitle: String,
    action: @escaping () -> Void
  ) {
    self.title = title
    self.subTitle = subTitle
    self.buttonTitle = buttonTitle
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
  var button: some View {
    OutlinedStyleButton(
      .small(contentType: .text),
      title: buttonTitle,
      buttonType: .throttle,
      action: action
    )
  }
}
