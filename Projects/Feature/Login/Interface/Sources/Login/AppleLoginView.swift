//
//  AppleLoginView.swift
//  FeatureLoginInterface
//
//  Created by 임현규 on 8/23/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct AppleLoginView: View {
  private let store: StoreOf<AppleLoginFeature>
  
  public init(store: StoreOf<AppleLoginFeature>) {
    self.store = store
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      Spacer()
        .frame(height: 52)
      whiteLogo
        .padding(.top, 52)
        .padding(.bottom, .xl)
      mainText
        
      Spacer()

      signInWithAppleButton
        .padding(.bottom, 30.0)

    }
    .background {
      BottleImageView(
        type: .local(bottleImageSystem: .illustraition(.loginBackground))
      )
    }
    .setNavigationBar {
      makeNaivgationleftButton() {
        store.send(.backButtonDidTapped)
      }
    }
    .edgesIgnoringSafeArea([.top, .bottom])
  }
}

private extension AppleLoginView {
  var whiteLogo: some View {
    BottleImageView(type: .local(bottleImageSystem: .illustraition(.whiteLogo)))
      .frame(width: 117.1, height: 30)
  }
  
  var mainText: some View {
    WantedSansStyleText("진심을 담은 보틀로\n서로를 밀도있게 알아가요", style: .title2, color: .quaternary)
      .padding(.horizontal, .md)
      .multilineTextAlignment(.center)
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
}
