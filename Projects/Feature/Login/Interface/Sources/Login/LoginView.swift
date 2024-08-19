//
//  LoginView.swift
//  FeatureLogin
//
//  Created by JongHoon on 7/25/24.
//

import SwiftUI

import SharedDesignSystem
import FeatureOnboardingInterface
import FeatureGeneralSignUpInterface

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
            VStack(spacing: 12.0) {
              signInWithKakaoButton
              
              signInWithGeneralButton
              
              termsGuides
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
  
  var signInWithGeneralButton: some View {
    SolidButton(
      title: "일반 로그인",
      sizeType: .large,
      buttonType: .throttle,
      buttonApperance: .generalSignIn,
      action: { store.send(.signInGeneralButtonDidTapped) }
    )
    .padding(.horizontal, .md)
  }
  
  var termsGuides: some View {
    VStack(alignment: .center, spacing: .xxs) {
      HStack(spacing: 0.0) {
        WantedSansStyleText(
          "로그인 버튼을 누르면 ",
          style: .caption,
          color: .secondary
        )
        
        WantedSansStyleText(
          "개인정보처리방침",
          style: .caption,
          color: .secondary
        )
        .underline(color: ColorToken.text(.secondary).color)
        .asThrottleButton {
          store.send(.personalInformationTermButtonDidTapped)
        }
      }
      
      HStack(spacing: 0.0) {
        WantedSansStyleText(
          "보틀이용약관",
          style: .caption,
          color: .secondary
        )
        .underline(color: ColorToken.text(.secondary).color)
        .asThrottleButton {
          store.send(.utilizationTermButtonDidTapped)
        }
        
        WantedSansStyleText(
          "에 동의한 것으로 간주합니다.",
          style: .caption,
          color: .secondary
        )
      }
    }
  }
}
