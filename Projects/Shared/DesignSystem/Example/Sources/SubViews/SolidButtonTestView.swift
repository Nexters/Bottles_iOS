//
//  SolidButtonTestView.swift
//  DesignSystemExample
//
//  Created by 임현규 on 7/27/24.
//

import SwiftUI
import SharedDesignSystem

struct SolidButtonTestView: View {
  @State var isDisabledExtraSmallButton: Bool = false
  @State var isDisabledSmallButton: Bool = false
  @State var isDisabledMediumButton: Bool = false
  @State var isDisabledLargeButton: Bool = false
  @State var isDisabledFullButton: Bool = false
  
  @State var extraSmallButtonPadding: CGFloat = 0.0
  @State var smallButtonPadding: CGFloat = 0.0
  @State var mediumButtonPadding: CGFloat = 0.0
  @State var largeButtonPadding: CGFloat = 0.0
  @State var fullButtonPadding: CGFloat = 0.0
  
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
  var title: String
  @Binding var isDisabled: Bool
  @Binding var padding: CGFloat
  
  var sizeType: SolidButton.SizeType
  
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
