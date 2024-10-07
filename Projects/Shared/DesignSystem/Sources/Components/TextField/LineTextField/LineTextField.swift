//
//  LineTextField.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 8/12/24.
//

import SwiftUI

public struct LineTextField: View {
  @Binding private var text: String
  @Binding private var textFieldState: TextFieldState
  private let placeHolder: String
  
  public init(
    textFieldState: Binding<TextFieldState>,
    text: Binding<String>,
    placeHolder: String
  ) {
    self._textFieldState = textFieldState
    self._text = text
    self.placeHolder = placeHolder
  }
  
  public var body: some View {
    textField
  }
}

// MARK: - Views
private extension LineTextField {
  var textField: some View {
    TextField(placeHolder, text: $text)
      .padding(.horizontal, .md)
      .padding(.vertical, .lg)
      .overlay(
        RoundedRectangle(cornerRadius: BottleRadiusType.sm.value)
          .strokeBorder(ColorToken.border(.enabled).color, lineWidth: 1.0)
      )
      .background(to: containerColor)
      .overlay(alignment: .trailing) {
        clearButton
      }
      .font(to: .wantedSans(.body))
  }
  
  @ViewBuilder
  var clearButton: some View {
    if text.isEmpty {
      EmptyView()
    } else {
      BottleImageView(type: .local(bottleImageSystem: .icon(.delete)))
        .foregroundStyle(to: ColorToken.icon(.primary))
        .asThrottleButton {
          self.text = ""
        }
        .padding(.trailing, .md)
    }
  }
  
  var containerColor: ColorToken.Container {
    switch textFieldState {
    case .enabled: return .enablePrimary
    case .active:  return .Active
    case .focused: return .focusePrimary
    case .error:   return .erroPrimary
    }
  }
}
