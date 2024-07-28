//
//  SolidButtonTestView.swift
//  DesignSystemExample
//
//  Created by 임현규 on 7/27/24.
//

import SwiftUI
import SharedDesignSystem

struct SolidButtonTestView: View {
  @State private var isDisabledExtraSmallButton: Bool = false
  @State private var isDisabledSmallButton: Bool = false
  @State private var isDisabledMediumButton: Bool = false
  @State private var isDisabledLargeButton: Bool = false
  @State private var isDisabledFullButton: Bool = false
  
  @State private var extraSmallButtonPadding: CGFloat = 0.0
  @State private var smallButtonPadding: CGFloat = 0.0
  @State private var mediumButtonPadding: CGFloat = 0.0
  @State private var largeButtonPadding: CGFloat = 0.0
  @State private var fullButtonPadding: CGFloat = 0.0
  
  var body: some View {
    ScrollView {
      VStack(spacing: 30) {
        Text("Solid Button")
          .font(to: .wantedSans(.title1))

        ButtonToggleView(
          title: "Extra Small",
          isDisabled: $isDisabledExtraSmallButton,
          padding: $extraSmallButtonPadding,
          sizeType: .extraSmall
        )
        
        ButtonToggleView(
          title: "Small",
          isDisabled: $isDisabledSmallButton, 
          padding: $smallButtonPadding,
          sizeType: .small
        )        

        
        ButtonToggleView(
          title: "Medium",
          isDisabled: $isDisabledMediumButton,
          padding: $mediumButtonPadding,
          sizeType: .medium
        )
        
        ButtonToggleView(
          title: "Large",
          isDisabled: $isDisabledLargeButton,
          padding: $largeButtonPadding,
          sizeType: .large
        )
        
        ButtonToggleView(
          title: "Full",
          isDisabled: $isDisabledFullButton,
          padding: $fullButtonPadding,
          sizeType: .full
        )
      }
    }
  }
}

struct ButtonToggleView: View {
  @Binding private var isDisabled: Bool
  @Binding private var padding: CGFloat
  private var title: String
  private var sizeType: SolidButton.SizeType
  
  init(
    title: String,
    isDisabled: Binding<Bool>,
    padding: Binding<CGFloat>,
    sizeType: SolidButton.SizeType
  ) {
    self._isDisabled = isDisabled
    self._padding = padding
    self.title = title
    self.sizeType = sizeType
  }
  
  var body: some View {
    VStack(spacing: 10) {
      Text("\(sizeType) Button")
        .font(to: .wantedSans(.subTitle1))
      
      Slider(value: $padding, in: 0.0...200)
        .padding(.horizontal, 100)
      
      Text("horizontal Padding = \(Int(padding))")

      Toggle(isOn: $isDisabled) {
        Text(title)
          .font(to: .wantedSans(.body))
      }
      .padding(.horizontal, 100)
      
      SolidButton(
        title: title,
        sizeType: sizeType,
        buttonType: .normal,
        action: { print("\(title) Button clicked") }
      )
      .disabled(isDisabled)
      .padding(.horizontal, padding)
      
      Divider()
        .background(.black)
        .padding(.horizontal, 20)
    }
  }
}

#Preview {
  SolidButtonTestView()
}
