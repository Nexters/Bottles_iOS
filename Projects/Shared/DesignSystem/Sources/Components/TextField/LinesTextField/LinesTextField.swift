//
//  LinesTextField.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 7/28/24.
//

import SwiftUI

public struct LinesTextField: View {
  @State private var content: String = ""

  private let textFieldType: LinesTextFieldType
  private let errorMessage: String?
  private let buttonTitle: String?
  private let placeHolder: String
  
  public init(textFieldType: LinesTextFieldType, placeHolder: String, buttonTitle: String? = nil, errorMessage: String? = nil) {
    self.textFieldType = textFieldType
    self.placeHolder = placeHolder
    self.buttonTitle = buttonTitle
    self.errorMessage = errorMessage
  }
  
  public var body: some View {
    RoundedRectangle(cornerRadius: BottleRadiusType.xl.value)
      .strokeBorder(
        ColorToken.border(.enabled).color,
        lineWidth: 1
      )
      .frame(height: height)
      .background(to: .container(.enablePrimary))
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

// MARK: - Private Extension

private extension LinesTextField {
  var height: CGFloat {
    switch textFieldType {
    case .introduction: return 197
    case .letter:       return 186
    }
  }
  
  var textCountLimit: Int {
    switch textFieldType {
    case .introduction: return 100
    case .letter:       return 150
    }
  }
}

// MARK: - Views

private extension LinesTextField {
  var textCounter: some View {
    Text("\(content.count) / \(textCountLimit)")
      .font(to: .wantedSans(.body))
      .foregroundStyle(to: .text(.enableTertiary))
      .padding(.md)
      .onChange(of: content) { _, newValue in
        if newValue.count > textCountLimit {
          content = String(newValue.prefix(textCountLimit))
        }
      }
  }
  
  @ViewBuilder
  var textEditer: some View {
    GeometryReader { geometry in
      let height = geometry.size.height
      TextEditor(text: $content)
        .clipShape(RoundedRectangle(cornerRadius: BottleRadiusType.sm.value))
        .font(to: .wantedSans(.body))
        .colorMultiply(to: .onContainer(.enablePrimary))
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
      textEditer
    case .letter:
      VStack(spacing: .md) {
        textEditer
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
