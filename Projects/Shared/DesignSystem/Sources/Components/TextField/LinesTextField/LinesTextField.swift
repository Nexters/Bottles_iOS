//
//  LinesTextField.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/28/24.
//

import SwiftUI
import Combine

public struct LinesTextField: View {
  @Binding private var text: String
  @Binding private var textFieldState: TextFieldState
  
  private let textFieldType: LinesTextFieldType
  private let errorMessage: String?
  private let buttonTitle: String?
  private let placeHolder: String
  private let textLimit: Int
  
  public init(
    textFieldType: LinesTextFieldType,
    textFieldState: Binding<TextFieldState>,
    text: Binding<String>,
    placeHolder: String,
    buttonTitle: String? = nil,
    errorMessage: String? = nil,
    textLimit: Int
  ) {
    self.textFieldType = textFieldType
    self._textFieldState = textFieldState
    self._text = text
    self.placeHolder = placeHolder
    self.buttonTitle = buttonTitle
    self.errorMessage = errorMessage
    self.textLimit = textLimit
  }
  
  public var body: some View {
    VStack(spacing: .xxs) {
      RoundedRectangle(cornerRadius: BottleRadiusType.xl.value)
        .strokeBorder(
          borderColor.color,
          lineWidth: 1
        )
        .frame(height: height)
        .background(to: containerColor)
        .overlay(alignment: .center) {
          linesTextFieldForm
            .padding(.md)
        }
      
      errorText
    }
  }
}

// MARK: - Public Extension

public extension LinesTextField {
  enum LinesTextFieldType {
    case introduction
    case letter
  }
}

// MARK: - Views

private extension LinesTextField {
  var textCounter: some View {
    Text("\(text.count) / \(textLimit)")
      .font(to: .wantedSans(.body))
      .foregroundStyle(to: textColor)
      .padding(.md)
  }
  
  var placeHolderText: some View {
    Text(placeHolder)
      .lineSpacing(6)
      .padding(.leading, 5)
      .padding(.top, 8)
      .font(to: .wantedSans(.body))
      .foregroundStyle(to: textColor)
  }
  
  var textEditor: some View {
    GeometryReader { geometry in
      let height = geometry.size.height
      TextEditor(text: $text)
        .lineSpacing(6)
        .background(alignment: .topLeading) {
          if text.isEmpty && textFieldState == .enabled { placeHolderText }
        }
        .padding(.md)
        .background(to: textEditorColor)
        .clipShape(RoundedRectangle(cornerRadius: BottleRadiusType.sm.value))
        .scrollContentBackground(.hidden)
        .font(to: .wantedSans(.body))
        .frame(height: height)
        .overlay(alignment: .bottomTrailing) {
          textCounter
        }
    }
  }
  
  @ViewBuilder
  var linesTextFieldForm: some View {
    switch textFieldType {
    case .introduction:
      textEditor
    case .letter:
      VStack(spacing: .md) {
        textEditor
        SolidButton(
          title: buttonTitle ?? "",
          sizeType: .medium,
          buttonType: .normal,
          action: {}
        )
        .disabled(isDisabledButton)
      }
    }
  }
  
  @ViewBuilder
  var errorText: some View {
    if let errorMessage {
      if textFieldState == .error {
        HStack(spacing: 0) {
          WantedSansStyleText(
            errorMessage,
            style: .caption,
            color: .errorPrimary)
          Spacer()
        }
      }
    } else {
      EmptyView()
    }
  }
}

// MARK: - Private Extension

private extension LinesTextField {
  var height: CGFloat {
    switch textFieldType {
    case .introduction: return 301
    case .letter:       return 186
    }
  }
  
  var textColor: ColorToken.TextToken {
    switch textFieldState {
    case .enabled: return .enableTertiary
    case .active:  return .activePrimary
    case .focused: return .focusePrimary
    case .error:   return .errorSecondary
    }
  }
  
  var borderColor: ColorToken.Border {
    switch textFieldState {
    case .enabled: return .enabled
    case .active:  return .active
    case .focused: return .focused
    case .error:   return .error
    }
  }
  
  var textEditorColor: ColorToken.OnContainer {
    switch textFieldState {
    case .enabled: return .enablePrimary
    case .active:  return .active
    case .focused: return .focuse
    case .error:   return .error
    }
  }
  
  var containerColor: ColorToken.Container {
    switch textFieldState {
    case .enabled: return .enablePrimary
    case .active:  return .Active
    case .focused: return .focuseSecondary
    case .error:   return .errorSecondary
    }
  }
  
  var isDisabledButton: Bool {
    switch textFieldState {
    case .enabled: return true
    case .active:  return false
    case .focused: return false
    case .error:   return true
    }
  }
}
