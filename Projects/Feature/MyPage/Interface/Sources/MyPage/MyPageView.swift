//
//  MyPageView.swift
//  FeatureMyPageInterface
//
//  Created by JongHoon on 7/24/24.
//

import SwiftUI
import Contacts

import FeatureTabBarInterface
import FeatureBaseWebViewInterface
import FeatureGeneralSignUpInterface

import CoreLoggerInterface

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
      .task {
        store.send(.onAppear)
      }
      .overlay {
        if store.isShowLoadingProgressView {
          WithPerceptionTracking {
            LoadingIndicator()
          }
        }
      }
      .bottleAlert($store.scope(state: \.destination?.alert, action: \.destination.alert))
      .sheet(isPresented: $store.isPresentTerms) {
        store.send(.termsWebViewDidDismiss)
      } content: {
        TermsWebView(url: store.temrsURL ?? "")
      }
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
      .asThrottleButton {
        store.send(.profileEditListDidTapped)
      }
  }
  
  var blockPhoneNumberList: some View {
    ButtonListView(
      title: "연락처 차단",
      subTitle: "연락처 속 \(store.blockedContactsCount)명을 차단했어요",
      buttonTitle: "업데이트",
      action: {
        store.send(.updatePhoneNumberForBlockButtonDidTapped)
      }
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
    ButtonListView(
      title: "앱 버전",
      subTitle: "\(store.currentAppVersion ?? "0.0.0")",
      buttonTitle: "업데이트",
      isShowButton: store.isShowApplicationUpdateButton,
      action: {
        store.send(.updateApplicationButtonTapped)
      }
    )
  }
  
  var contactList: some View {
    ArrowListView(title: "1:1 문의")
      .asThrottleButton(action: { store.send(.contactListDidTapped) })
  }
  
  var termsOfServiceList: some View {
    ArrowListView(title: "보틀 이용 약관")
      .asThrottleButton(action: { store.send(.termsOfServiceListDidTapped) })
  }
  
  var privacyPolicyList: some View {
    ArrowListView(title: "개인정보처리방침")
      .asThrottleButton(action: { store.send(.privacyPolicyListDidTapped) })
  }
}
