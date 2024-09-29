//
//  BaseWebViewSettingView.swift
//  FeatureBaseWebViewExample
//
//  Created by 임현규 on 9/29/24.
//

import SwiftUI

import FeatureBaseWebViewInterface

import SharedDesignSystem

import ComposableArchitecture

public struct BaseWebViewSettingView: View {
  @Perception.Bindable private var store: StoreOf<BaseWebViewSettingFeature>
  
  public init(store: StoreOf<BaseWebViewSettingFeature>) {
    self.store = store
  }

  public var body: some View {
    VStack(spacing: .md) {
      VStack(spacing: .xs) {
        HStack(spacing: 0.0) {
          WantedSansStyleText(
            "AccessToken 설정하기",
            style: .title1,
            color: .activePrimary
          )
          Spacer()
        }
        .padding(.leading, .md)
        HStack(spacing: .md) {
          SolidButton(
            title: "카리나",
            sizeType: .medium,
            buttonType: .throttle,
            action: { store.send(.karinaButtonDidTapped) }
          )
          
          SolidButton(
            title: "차은우",
            sizeType: .medium,
            buttonType: .throttle,
            action: { store.send(.unwooButtonDidTapped) }
          )
        }
        .padding(.md)
      }
      
      HStack(spacing: 0.0) {
        WantedSansStyleText(
          "URL 설정하기",
          style: .title1,
          color: .activePrimary
        )
        Spacer()
      }
      .padding(.leading, .md)
      
      LineTextField(
        textFieldState: .constant(.active),
        text: $store.path,
        placeHolder: "path만 입력해주세요 ex) profile/edit"
      )
        .padding(.md)
      
      Spacer()
      
      SolidButton(
        title: "웹 뷰 띄우기",
        sizeType: .full,
        buttonType: .throttle,
        action: { store.send(.openWebViewButtonDidTapped) }
      )
      .padding(.md)
    }
  }
}
