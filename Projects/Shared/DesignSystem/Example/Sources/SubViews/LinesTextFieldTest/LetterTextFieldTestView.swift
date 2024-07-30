//
//  LetterTextFieldTestView.swift
//  DesignSystemExample
//
//  Created by 임현규 on 7/28/24.
//

import SwiftUI

import SharedDesignSystem

struct LetterTextFieldTestView: View {
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
          textFieldType: .letter,
          textFieldState: $enabledState,
          text: $text,
          placeHolder: "place holder",
          buttonTitle: "작성 완료",
          textLimit: 150
        )
        .padding(.sm)

        Text("focusedState TextFields")
          .font(to: .wantedSans(.title1))
        
        LinesTextField(
          textFieldType: .letter,
          textFieldState: $focuseState,
          text: $text,
          placeHolder: "place holder",
          buttonTitle: "작성 완료",
          textLimit: 150
        )
        .padding(.sm)
        
        Text("activeState TextFields")
          .font(to: .wantedSans(.title1))
        
        LinesTextField(
          textFieldType: .letter,
          textFieldState: $activeState,
          text: $text,
          placeHolder: "place holder",
          buttonTitle: "작성 완료",
          textLimit: 150
        )
        .padding(.sm)
        
        Text("errorState TextFields")
          .font(to: .wantedSans(.title1))
        
        LinesTextField(
          textFieldType: .letter,
          textFieldState: $errorState,
          text: $text,
          placeHolder: "place holder",
          buttonTitle: "작성 완료",
          textLimit: 150
        )
        .padding(.sm)
        
      }
    }
  }
}
#Preview {
    LetterTextFieldTestView()
}
