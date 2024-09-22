//
//  MyPageView.swift
//  FeatureMyPageInterface
//
//  Created by JongHoon on 7/24/24.
//

import SwiftUI

import FeatureTabBarInterface
import FeatureBaseWebViewInterface
import SharedDesignSystem

import ComposableArchitecture

public struct MyPageView: View {
  @Perception.Bindable private var store: StoreOf<MyPageFeature>
  
  public init(store: StoreOf<MyPageFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      ScrollView {
        VStack(spacing: 0) {
          Spacer()
            .frame(height: 52.0)
          userProfile
          profileEditList
          
          VStack(spacing: .lg) {
            blockPhoneNumberList
            pushSettingList
            accountSettingList
            Divider()
            appVersionList
            contactList
            Divider()
            termsOfServiceList
            privacyPolicyList
          }
          .padding(.horizontal, .md)
          .padding(.vertical, .xl)
          .overlay(roundedRectangle)
        }
        .padding(.horizontal, .md)
      }
      .scrollIndicators(.hidden)
      .background(to: ColorToken.container(.primary))
      .padding(.bottom, 106)
      .padding(.top, 1)
      .setTabBar(selectedTab: .myPage) { selectedTab in
        store.send(.selectedTabDidChanged(selectedTab))
      }
      .onLoad {
        store.send(.onLoad)
      }
      .overlay {
        if store.isShowLoadingProgressView {
          WithPerceptionTracking {
            LoadingIndicator()
          }
        }
      }
      .alert($store.scope(state: \.destination?.alert, action: \.destination.alert))
    }
  }
}

// MARK: - Views
private extension MyPageView {
  var userProfile: some View {
    VStack(spacing: .sm) {
      RemoteImageView(
        imageURL: store.userInfo.userImageURL,
        downsamplingWidth: 80.0,
        downsamplingHeight: 80.0
      )
      .clipShape(Circle())
      .frame(width: 80, height: 80)
      
      WantedSansStyleText(
        store.userInfo.userName,
        style: .subTitle1,
        color: .secondary)
    }
    .padding(.bottom, .xl)
  }
  
  var roundedRectangle: some View {
    RoundedRectangle(cornerRadius: BottleRadiusType.xl.value)
      .strokeBorder(
        ColorToken.border(.primary).color,
        lineWidth: 1
      )
  }
  
  var profileEditList: some View {
    ArrowListView(title: "프로필 수정")
      .padding(.horizontal, .md)
      .padding(.vertical, .xl)
      .overlay(roundedRectangle)
      .padding(.bottom, .md)
  }
  
  var blockPhoneNumberList: some View {
    ButtonListView(
      title: "연락처 차단",
      subTitle: "연락처 속 0명을 차단했어요",
      buttonTitle: "업데이트",
      action: {}
    )
  }
  
  var pushSettingList: some View {
    ArrowListView(title: "알림 설정")
      .asThrottleButton(action: { store.send(.alertSettingListDidTapped)})
  }
  
  var accountSettingList: some View {
    ArrowListView(title: "계정 관리")
      .asThrottleButton(action: { store.send(.accountSettingListDidTapped) })
  }
  
  var appVersionList: some View {
    ArrowListView(title: "앱 버전", subTitle: "0.0.0")
  }
  
  var contactList: some View {
    ArrowListView(title: "1:1 문의")
  }
  
  var termsOfServiceList: some View {
    ArrowListView(title: "보틀 이용 약관")
  }
  
  var privacyPolicyList: some View {
    ArrowListView(title: "개인정보처리방침")
  }
}
