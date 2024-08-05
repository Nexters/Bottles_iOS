//
//  ProfileSetupView.swift
//  FeatureProfileSetupInterface
//
//  Created by 임현규 on 8/5/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct ProfileSetupView: View {
  @State var store: StoreOf<ProfileSetupFeature>
  @FocusState private var isTextFieldFocused: Bool

  public init(store: StoreOf<ProfileSetupFeature>) {
    self.store = store
  }
  
  public var body: some View {
    ScrollView {
      introductionTitle
      introductionTextField
      keywordList
      nextButton
    }
  }
}

private extension ProfileSetupView {
  var introductionTitle: some View {
    TitleView(
      pageInfo: PageInfo(nowPage: 1, totalCount: 2),
      title: "보틀에 담을\n소개를 작성해 주세요",
      caption: "수정이 어려우니 신중하게 작성해주세요"
    )
    .padding(.bottom, 32)
    .padding(.horizontal, .md)
  }
  
  var introductionTextField: some View {
    LinesTextField(
      textFieldType: .introduction,
      textFieldState: $store.textFieldState,
      text: $store.introductionText,
      placeHolder: "호기심이 많고 새로운 경험을 즐깁니다. 주말엔 책을 읽거나 맛집을 찾아다니며 여유를 즐기고, 친구들과 소소한 모임으로 에너지를 충전해요.",
      textLimit: 300
    )
    .focused($isTextFieldFocused)
    .onChange(of: isTextFieldFocused) { isFocused in
      store.send(.texFieldDidFocused(isFocused: isFocused))
    }
    .padding(.horizontal, .md)
    .padding(.bottom, .sm)
  }
  
  var keywordList: some View {
    ClipListContainerView(
      clipItemList: [
        ClipItem(
          title: "내 키워드를 참고해보세요",
          list: ["직장인", "MBTI", "city_name", "height", "흡연 안해요", "술을 즐겨요"]
        ),
        ClipItem(
          title: "나의 성격은",
          list: ["적극적인", "열정적인", "예의바른", "자유로운", "쿨한"]
        ),
        ClipItem(
          title: "내가 푹 빠진 취미는",
          list: ["코인노래방", "헬스", "드라이브", "만화 웹툰 정주행", "자전거"]
        )
      ]
    )
    .padding(.horizontal, .md)
    .padding(.bottom, 47)
  }
  
  var nextButton: some View {
    SolidButton(
      title: "다음",
      sizeType: .full,
      buttonType: .throttle,
      action: { }
    )
    .padding(.horizontal, .md)
  }
}
