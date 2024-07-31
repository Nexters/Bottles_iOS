//
//  LoginView.swift
//  FeatureLogin
//
//  Created by JongHoon on 7/25/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct LoginView: View {
  let store: StoreOf<LoginFeature>
  
  public init(store: StoreOf<LoginFeature>) {
    self.store = store
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      Spacer()
      mainText
      Spacer()
        .frame(height: 52)
      bottleImage
      Spacer()
      signInWithKakaoButton
      Spacer()
        .frame(height: 21)
    }
  }
}

public extension LoginView {
  var mainText: some View {
    LaundryGothicStyleText("진심을 담은 보틀로\n서로를 밀도있게 알아가요", style: .title1, color: .primary)
      .padding(.horizontal, .md)
      .border(.red)
      .multilineTextAlignment(.center)
  }
  
  var bottleImage: some View {
    BottleImageView(type: .remote(
      url: "https://static.wikia.nocookie.net/wallaceandgromit/images/3/38/Gromit-3.png/revision/latest/scale-to-width/360?cb=20191228190308",
      downsamplingWidth: 180,
      downsamplingHeight: 180))
    .frame(width: 180, height: 180)
    .border(.red)
  }
  
  // TODO: 카카오 로그인 버튼 Style로 수정
  var signInWithKakaoButton: some View {
    SolidButton(
      title: "카카오 로그인",
      sizeType: .large,
      buttonType: .debounce,
      action: {}
    )
    .padding(.horizontal, .md)
  }
}
