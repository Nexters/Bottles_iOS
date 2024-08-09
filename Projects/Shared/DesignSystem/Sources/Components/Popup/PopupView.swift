//
//  PopupView.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/28/24.
//

import SwiftUI

public struct PopupView: View {
  private var popupType: PopupType
  private let _action: (() -> Void)?
  private var action: () -> Void {
    return _action ?? {}
  }

  public init(popupType: PopupType, action: (() -> Void)? = nil) {
    self.popupType = popupType
    self._action = action
  }
  
  public var body: some View {
    popupItem
      .overlay(
        TriangleView(
          triangleWidth: triangleWidth,
          triangleHeight: triangleHeight
        )
      )
      .background {
        RoundedRectangle(cornerRadius: BottleRadiusType.lg.value)
          .fill(ColorToken.container(.primary).color)
      }
  }
}

// MARK: Views
private extension PopupView {
  var popupText: some View {
    switch popupType {
    case .text(let content):
      WantedSansStyleText(content, style: .subTitle2, color: .secondary)
    case .button(let content, _):
      WantedSansStyleText(content, style: .subTitle2, color: .secondary)
    }
  }
  
  var popupRectangle: some View {
    RoundedRectangle(cornerRadius: BottleRadiusType.md.value)
      .strokeBorder(
        ColorToken.border(.primary).color,
        lineWidth: 1
      )
  }
  
  @ViewBuilder
  var popupItem: some View {
    switch popupType {
    case .text:
      popupText
        .padding(.sm)
    case .button(_, let buttonTitle):
      VStack(spacing: .sm) {
        popupText
        SolidButton(title: buttonTitle,
                    sizeType: .small,
                    buttonType: .normal,
                    action: action)
        .frame(width: 227)
      }
      .padding(.lg)
    }
  }
}

// MARK: - Private Extension
private extension PopupView {
  var triangleWidth: CGFloat {
    return 10.39
  }
  var triangleHeight: CGFloat { 
    return 6
  }
  
  var height: CGFloat {
    switch popupType {
    case .button: return 106
    case .text:   return 42
    }
  }
}
