//
//  AlertSettingView.swift
//  FeatureMyPageInterface
//
//  Created by 임현규 on 9/21/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct AlertSettingView: View {
  @Perception.Bindable private var store: StoreOf<AlertSettingFeature>
  
  public init(store: StoreOf<AlertSettingFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      
      VStack(spacing: 0) {
        VStack(spacing: .lg) {
          randomBottleToggle
          arrivalBottleToggle
          pingpongToggle
          Divider()
          marketingToggle
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
      .bottleAlert($store.scope(state: \.destination?.alert, action: \.destination.alert))
      .onLoad { store.send(.onLoad) }
    }
  }
}

private extension AlertSettingView {
  var roundedRectangle: some View {
    RoundedRectangle(cornerRadius: BottleRadiusType.xl.value)
      .strokeBorder(
        ColorToken.border(.primary).color,
        lineWidth: 1
      )
  }
  
  var randomBottleToggle: some View {
    ToggleListView(
      title: "떠나니는 보틀 알림",
      subTitle: "매일 랜덤으로 추천되는 보틀 안내",
      isOn: $store.isOnRandomBottleToggle
    )
  }
  
  var arrivalBottleToggle: some View {
    ToggleListView(
      title: "호감 도착 안내",
      subTitle: "내가 받은 호감 안내",
      isOn: $store.isOnArrivalBottleToggle
    )
  }
  
  var pingpongToggle: some View {
    ToggleListView(
      title: "대화 알림",
      subTitle: "가치관 문답 시작 · 진행 · 중단 , 매칭 안내",
      isOn: $store.isOnPingPongToggle
    )
  }
  
  var marketingToggle: some View {
    ToggleListView(
      title: "마케팅 수신 동의",
      isOn: $store.isOnMarketingToggle
    )
  }
}
