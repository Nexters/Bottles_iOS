//
//  IntroductionSetupView.swift
//  FeatureProfileSetupInterface
//
//  Created by 임현규 on 8/5/24.
//

import SwiftUI

import SharedDesignSystem
import CoreLoggerInterface

import ComposableArchitecture

public struct IntroductionSetupView: View {
  @Perception.Bindable private var store: StoreOf<IntroductionSetupFeature>
  @FocusState private var isTextFieldFocused: Bool
  
  public init(store: StoreOf<IntroductionSetupFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      if store.isLoading {
        LoadingIndicator()
      } else {
        ScrollView {
          introductionTitle
          introductionTextField
          keywordList
          nextButton
        }.onTapGesture {
          store.send(.onTapGesture)
        }.setNavigationBar {
          makeNaivgationleftButton {
            store.send(.backButtonDidTapped)
          }
        }
      }
    }
    .onLoad {
      store.send(.onLoad)
    }
    .ignoresSafeArea(.all, edges: .bottom)
    .toolbar(.hidden, for: .bottomBar)
  }
}

private extension IntroductionSetupView {
  var introductionTitle: some View {
    TitleView(
      pageInfo: PageInfo(nowPage: 1, totalCount: 2),
      title: "보틀에 담을\n소개를 작성해 주세요",
      caption: "수정이 어려우니 신중하게 작성해주세요"
    )
    .padding(.top, .xl)
    .padding(.bottom, 32)
    .padding(.horizontal, .md)
  }
  
  var introductionTextField: some View {
    LinesTextField(
      textFieldType: .introduction,
      textFieldState: $store.textFieldState,
      text: $store.introductionText,
      placeHolder: "호기심이 많고 새로운 경험을 즐깁니다. 주말엔 책을 읽거나 맛집을 찾아다니며 여유를 즐기고, 친구들과 소소한 모임으로 에너지를 충전해요.",
      errorMessage: "최소 \(store.maxLength)글자 이상 작성해주세요",
      textLimit: 300
    )
    .focused($isTextFieldFocused)
    .padding(.horizontal, .md)
    .padding(.bottom, .sm)
    .onChange(of: isTextFieldFocused) { isFocused in
      store.send(.texFieldDidFocused(isFocused: isFocused))
    }
    .onChange(of: store.textFieldState) { textFieldState in
      Log.error(textFieldState)
      isTextFieldFocused = textFieldState == .active || textFieldState == .enabled ? false : true
    }
  }
  
  var keywordList: some View {
    ClipListContainerView(
      clipItemList: store.keywordItem
    )
    .padding(.horizontal, .md)
    .padding(.bottom, 47)
  }
  
  var nextButton: some View {
    SolidButton(
      title: "다음",
      sizeType: .full,
      buttonType: .throttle,
      action: { store.send(.nextButtonDidTapped) }
    )
    .padding(.horizontal, .md)
    .padding(.bottom, .xl)
    .disabled(store.isNextButtonDisable)
  }
}

extension View {
  func endTextEditing() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
