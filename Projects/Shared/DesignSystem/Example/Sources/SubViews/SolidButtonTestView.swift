//
//  SolidButtonTestView.swift
//  DesignSystemExample
//
//  Created by 임현규 on 7/27/24.
//

import SwiftUI
import SharedDesignSystem

struct SolidButtonTestView: View {
  var body: some View {
    ScrollView {
      VStack(spacing: 10) {
        Text("enabled Solied Button")
          .font(to: .wantedSans(.title1))
        
        SolidButton(
          title: "Text",
          sizeType: .extraSmall,
          buttonType: .normal,
          action: { print("click") }
        )
        
        SolidButton(
          title: "small",
          sizeType: .small,
          buttonType: .normal,
          action: { print("click") }
        )
        
        SolidButton(
          title: "medium",
          sizeType: .medium,
          buttonType: .normal,
          action: { print("click") }
        )
        
        SolidButton(
          title: "large",
          sizeType: .large,
          buttonType: .normal,
          action: { print("click") }
        )
        
        SolidButton(
          title: "full",
          sizeType: .full,
          buttonType: .normal,
          action: { print("click") }
        )
        
        Text("disabled Solied Button")
          .font(to: .wantedSans(.title1))
        
        SolidButton(
          title: "Text",
          sizeType: .extraSmall,
          buttonType: .normal,
          action: { print("click") }
        )
        .disabled(true)
        
        SolidButton(
          title: "small",
          sizeType: .small,
          buttonType: .normal,
          action: { print("click") }
        )
        .disabled(true)

        SolidButton(
          title: "medium",
          sizeType: .medium,
          buttonType: .normal,
          action: { print("click") }
        )
        .disabled(true)

        SolidButton(
          title: "large",
          sizeType: .large,
          buttonType: .normal,
          action: { print("click") }
        )
        .disabled(true)

        SolidButton(
          title: "full",
          sizeType: .full,
          buttonType: .normal,
          action: { print("click") }
        )
        .disabled(true)
      }
    }
  }
}

#Preview {
  SolidButtonTestView()
}
