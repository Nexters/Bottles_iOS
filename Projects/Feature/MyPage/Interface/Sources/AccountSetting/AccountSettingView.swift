//
//  AccountSettingView.swift
//  FeatureMyPageInterface
//
//  Created by 임현규 on 9/21/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct AccountSettingView: View {
  @Perception.Bindable private var store: StoreOf<AccountSettingFeature>
  
  public init(store: StoreOf<AccountSettingFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      
      VStack(spacing: 0) {
        VStack(spacing: .lg) {
          matchingToggle
          logoutList
          withdrawList
        }
        .padding(.horizontal, .md)
        .padding(.vertical, .xl)
        .overlay(roundedRectangle)
        .padding(.top, 32)
        Spacer()
      }
      .padding(.horizontal, .lg)
      .setNavigationBar {
        makeNaivgationleftButton { store.send(.backButtonDidTapped) }
      }
      .onLoad { store.send(.onLoad) }
    }
  }
}

private extension AccountSettingView {
  var roundedRectangle: some View {
    RoundedRectangle(cornerRadius: BottleRadiusType.xl.value)
      .strokeBorder(
        ColorToken.border(.primary).color,
        lineWidth: 1
      )
  }
  
  var matchingToggle: some View {
    ToggleListView(
      title: "매칭 활성화",
      subTitle: "비활성화 시 다른 사람을 추천 받을 수 없고\n회원님도 다른 사람에게 추천되지 않아요",
      isOn: $store.isOnMatchingToggle
    )
  }
  
  var logoutList: some View {
    ArrowListView(title: "로그아웃")
  }
  
  var withdrawList: some View {
    ArrowListView(title: "탈퇴하기")
  }
}
