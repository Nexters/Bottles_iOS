//
//  LoginView.swift
//  FeatureLogin
//
//  Created by JongHoon on 7/25/24.
//

import SwiftUI
import AuthenticationServices

import FeatureOnboardingInterface
import FeatureGeneralSignUpInterface
import FeatureGuideInterface

import CoreLoggerInterface

import SharedDesignSystem

import ComposableArchitecture

public struct LoginView: View {
  @Perception.Bindable private var store: StoreOf<LoginFeature>
  
  public init(store: StoreOf<LoginFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
          VStack(spacing: 0) {
            Spacer()
              .frame(height: 52)
            whiteLogo
              .padding(.top, 52)
              .padding(.bottom, .xl)
            
            mainText
              
            Spacer()
            
            VStack(spacing: 30.0) {
              signInWithKakaoButton
              snsLoginButton
            }
            .padding(.bottom, 30.0)
          }
          .background {
            BottleImageView(
              type: .local(bottleImageSystem: .illustraition(.loginBackground))
            )
          }
          .edgesIgnoringSafeArea([.top, .bottom])
          .sheet(
            isPresented: $store.isPresentTermView,
            content: {
              TermsWebView(url: store.termURL)
            }
          )
          .overlay {
            if store.isLoading {
              LoadingIndicator()
            }
          }

      } destination: { store in
        WithPerceptionTracking {
          switch store.state {
          case .generalLogin:
            if let store = store.scope(state: \.generalLogin, action: \.generalLogin) {
              GeneralLogInView(store: store)
            }

          case .onBoarding:
            if let store = store.scope(state: \.onBoarding, action: \.onBoarding) {
              OnboardingView(store: store)
            }

          case .generalSignUp:
            if let store = store.scope(state: \.generalSignUp, action: \.generalSignUp) {
              GeneralSignUpView(store: store)
            }
            
          case .mainGuide:
            if let store = store.scope(state: \.mainGuide, action: \.mainGuide) {
              MainGuideView(store: store)
            }
            
          case .pingPongGuide:
            if let store = store.scope(state: \.pingPongGuide, action: \.pingPongGuide) {
              PingPongGuideView(store: store)
            }
            
          case .photoShareGuide:
            if let store = store.scope(state: \.photoShareGuide, action: \.photoShareGuide) {
              PhotoShareGuideView(store: store)
            }
            
          case .startGuide:
            if let store = store.scope(state: \.startGuide, action: \.startGuide) {
              StartGuideView(store: store)
			}

          case .appleLogin:
            if let store = store.scope(state: \.appleLogin, action: \.appleLogin) {
              AppleLoginView(store: store)
          }
        }
      }
    }
  }
}

public extension LoginView {
  var whiteLogo: some View {
    BottleImageView(type: .local(bottleImageSystem: .illustraition(.whiteLogo)))
      .frame(width: 117.1, height: 30)
  }
  
  var mainText: some View {
    WantedSansStyleText("진심을 담은 보틀로\n서로를 밀도있게 알아가요", style: .title2, color: .quaternary)
      .padding(.horizontal, .md)
      .multilineTextAlignment(.center)
  }
  
  var bottleImage: some View {
    BottleImageView(type: .remote(
      url: "https://static.wikia.nocookie.net/wallaceandgromit/images/3/38/Gromit-3.png/revision/latest/scale-to-width/360?cb=20191228190308",
      downsamplingWidth: 180,
      downsamplingHeight: 180))
    .frame(width: 180, height: 180)
  }
  
  // TODO: 카카오 로그인 버튼 Style로 수정
  var signInWithKakaoButton: some View {
    SolidButton(
      title: "카카오 로그인",
      sizeType: .large,
      buttonType: .throttle,
      buttonApperance: .kakao,
      action: { store.send(.signInKakaoButtonDidTapped) }
    )
    .padding(.horizontal, .md)
  }
  
  var signInWithAppleButton: some View {
    SolidButton(
      title: "Apple로 로그인",
      sizeType: .large,
      buttonType: .throttle,
      buttonApperance: .apple,
      action: { store.send(.signInAppleButtonDidTapped) }
    )
    .padding(.horizontal, .md)
  }
  
  var snsLoginButton: some View {
    WantedSansStyleText(
      "한국 전화번호가 없나요? SNS로 로그인하기",
      style: .caption,
      color: .enableQuaternary
    )
    .asThrottleButton {
      store.send(.snsLoginButtonDidTapped)
    }
  }
}
