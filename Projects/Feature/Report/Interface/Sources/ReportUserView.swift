//
//  ReportUserView.swift
//  FeatureReportInterface
//
//  Created by 임현규 on 8/12/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct ReportUserView: View {
  @Perception.Bindable private var store: StoreOf<ReportUserFeature>
  @FocusState private var isTextFieldFocused: Bool
  
  public init(store: StoreOf<ReportUserFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      VStack(spacing: .xl) {
        TitleView(title: "신고 사유를 간단하게\n작성해주세요")
        UserProfileView(imageURL: store.userProfile.imageURL, userName: store.userProfile.userName, userAge: store.userProfile.userAge)
        
        LineTextField(textFieldState: $store.textFieldState, text: $store.reportText, placeHolder: "예) 욕설을 사용했습니다.")
          .focused($isTextFieldFocused)
          .onChange(of: isTextFieldFocused) { isFocused in
            store.send(.texFieldDidFocused(isFocused: isFocused))
          }
          .onChange(of: store.textFieldState) { textFieldState in
            isTextFieldFocused = textFieldState == .active || textFieldState == .enabled ? false : true
          }
        
        Spacer()
        
        SolidButton(title: "완료", sizeType: .large, buttonType: .throttle) {
          store.send(.doneButtonDidTapped)
        }
        .disabled(store.isDisableDoneButton)
        .padding(.bottom, .lg)
      }.onTapEndEditing()
      .setNavigationBar {
        makeNaivgationleftButton() {
          store.send(.backButtonDidTapped)
        }
      }
      .padding(.horizontal, .md)
      .alert($store.scope(state: \.destination?.alert, action: \.destination.alert))
    }
  }
}
