//
//  SegmentControlButton.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 10/1/24.
//

import SwiftUI

public struct SegmentControlButton: View {
  private let title: String
  private let buttonType: ButtonType
  private let isSelected: Bool?
  private let _action: (() -> Void)?
  private var action: () -> Void {
    return _action ?? {}
  }
  
  public init(
    title: String,
    buttonType: ButtonType,
    isSelected: Bool? = nil,
    action: (() -> Void)? = nil
  ) {
    self.title = title
    self.buttonType = buttonType
    self.isSelected = isSelected
    self._action = action
  }
  
  public var body: some View {
    segmentControlButton
      .buttonStyle(SegmentControlButtonStyle(isSelected: isSelected))
  }
}

// MARK: - Private Views
private extension SegmentControlButton {
  var titleText: some View {
    Text(title)
      .font(to: .wantedSans(.body))
  }
  
  @ViewBuilder
  var segmentControlButton: some View {
    switch buttonType {
    case .debounce:
      titleText.asDebounceButton(action: action)
    case .throttle:
      titleText.asThrottleButton(action: action)
    case .normal:
      titleText.asButton(action: action)
    }
  }
}
