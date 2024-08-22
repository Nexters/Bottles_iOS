//
//  OutlinedStyleButtonTestItem.swift
//  SharedDesignSystem
//
//  Created by JongHoon on 7/28/24.
//

import SwiftUI

import SharedDesignSystem

struct OutlinedStyleButtonTestItem: View {
  @State private var isDisabled: Bool
  @State private var padding: CGFloat
  @Binding private var isSelected: Bool
  private let _action: (() -> Void)?
  private var action: () -> Void {
    return _action ?? { print("\(title) button did tap") }
  }
  
  var title: String
  private var configurationInfo: OutlinedStyleButton.ConfigurationInfo
  
  init(
    title: String,
    configurationInfo: OutlinedStyleButton.ConfigurationInfo,
    isSelected: Binding<Bool> = .constant(false),
    action: (() -> Void)? = nil
  ) {
    self.isDisabled = false
    self.padding = 0.0
    self.title = title
    self.configurationInfo = configurationInfo
    self._isSelected = isSelected
    self._action = action
  }

  var body: some View {
    LazyVStack(spacing: 10) {
      Text("\(title) Button")
        .font(to: .wantedSans(.subTitle1))

      Slider(value: $padding, in: 0.0...200)
        .padding(.horizontal, 100)

      Text("horizontal Padding = \(Int(padding))")

      Toggle(isOn: $isDisabled) {
        Text("button is disabled")
          .font(to: .wantedSans(.body))
      }
      .padding(.horizontal, 100)

      OutlinedStyleButton(
        configurationInfo,
        title: title,
        buttonType: .normal,
        isSelected: isSelected,
        action: action
      )
      .disabled(isDisabled)
      .padding(.horizontal, padding)
      .padding(.bottom, 20.0)

      Divider()
        .background(.black)
        .padding(.horizontal, 20)
    }
  }
}
