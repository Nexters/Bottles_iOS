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
          myIntroduction
          myKeywords
          
          HStack(spacing: 0) {
            Spacer()
            logoutButton
            Spacer()
            withdrawalButton
            Spacer()
          }
          .padding(.bottom, .xl)
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
    UserProfileView(
      imageURL: store.userInfo.userImageURL,
      userName: store.userInfo.userName,
      userAge: store.userInfo.userAge
    )
    .padding(.bottom, .xl)
  }
  
  @ViewBuilder
  var myIntroduction: some View {
    if store.introduction.answer == "" {
      EmptyView()
    } else {
      LettetCardView(title: "내가 쓴 편지" , letterContent: store.introduction.answer)
        .padding(.bottom, .sm)
    }
  }
  
  var myKeywords: some View {
    ClipListContainerView(clipItemList: store.keywordItem)
      .padding(.bottom, .md)
  }
  
  var logoutButton: some View {
    WantedSansStyleText(
      "로그아웃",
      style: .subTitle2,
      color: .enableSecondary
    )
    .asThrottleButton {
      store.send(.logOutButtonDidTapped)
    }
  }
  
  var withdrawalButton: some View {
    WantedSansStyleText(
      "탈퇴하기",
      style: .subTitle2,
      color: .enableSecondary
    )
    .asThrottleButton {
      store.send(.withdrawalButtonDidTapped)
    }
  }
}
