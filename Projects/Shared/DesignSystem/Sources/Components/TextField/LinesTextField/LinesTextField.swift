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
        .padding(.leading, 5)
        .padding(.top, 8)
        .font(to: .wantedSans(.body))
        .foregroundStyle(to: textColor)
  }
  
  @ViewBuilder
  var textEditor: some View {
    GeometryReader { geometry in
      let height = geometry.size.height
      TextEditor(text: $text)
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
      }
    }
  }
}

// MARK: - Private Extension

private extension LinesTextField {
  var height: CGFloat {
    switch textFieldType {
    case .introduction: return 197
    case .letter:       return 186
    }
  }
  
  var textColor: ColorToken {
    switch textFieldState {
    case .enabled: return .text(.enableTertiary)
    case .active:  return .text(.activePrimary)
    case .focused: return .text(.focusePrimary)
    case .error:   return .text(.errorSecondary)
    }
  }
  
  var borderColor: ColorToken {
    switch textFieldState {
    case .enabled: return .border(.enabled)
    case .active:  return .border(.active)
    case .focused: return .border(.focused)
    case .error:   return .border(.error)
    }
  }
  
  var textEditorColor: ColorToken {
    switch textFieldState {
    case .enabled: return .onContainer(.enablePrimary)
    case .active:  return .onContainer(.active)
    case .focused: return .onContainer(.focuse)
    case .error:   return .onContainer(.error)
    }
  }
  
  var containerColor: ColorToken {
    switch textFieldState {
    case .enabled: return .container(.enablePrimary)
    case .active:  return .container(.Active)
    case .focused: return .container(.focuseSecondary)
    case .error:   return .container(.errorSecondary)
    }
  }
}
