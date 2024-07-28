//
//  IntroductionTextFieldTestView.swift
//  DesignSystemExample
//
//  Created by 임현규 on 7/28/24.
//

import SwiftUI
import SharedDesignSystem

struct IntroductionTextFieldTestView: View {
  @State private var text = ""
  @State private var enabledState: TextFieldState = .enabled
  @State private var focuseState: TextFieldState = .focused
  @State private var activeState: TextFieldState = .active
  @State private var errorState: TextFieldState = .error
  
  var body: some View {
    ScrollView {
      VStack(spacing: 10) {
        
        Text("enabledState TextFields")
          .font(to: .wantedSans(.title1))
        
        LinesTextField(
          textFieldType: .introduction,
          textFieldState: $enabledState,
          text: $text,
          placeHolder: "place holder",
          textLimit: 100
        )
        .padding(.sm)

        Text("focusedState TextFields")
          .font(to: .wantedSans(.title1))
        
        LinesTextField(
          textFieldType: .introduction,
          textFieldState: $focuseState,
          text: $text,
          placeHolder: "place holder",
          textLimit: 100
        )
        .padding(.sm)
        
        Text("activeState TextFields")
          .font(to: .wantedSans(.title1))
        
        LinesTextField(
          textFieldType: .introduction,
          textFieldState: $activeState,
          text: $text,
          placeHolder: "place holder",
          textLimit: 100
        )
        .padding(.sm)
        
        Text("errorState TextFields")
          .font(to: .wantedSans(.title1))
        
        LinesTextField(
          textFieldType: .introduction,
          textFieldState: $errorState,
          text: $text,
          placeHolder: "place holder",
          textLimit: 100
        )
        .padding(.sm)
        
      }
    }
  }
}

#Preview {
    IntroductionTextFieldTestView()
}
