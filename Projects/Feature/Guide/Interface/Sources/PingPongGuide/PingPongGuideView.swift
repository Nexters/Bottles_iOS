//
//  PingPongGuideView.swift
//  FeatureGuideInterface
//
//  Created by 임현규 on 8/22/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct PingPongGuideView: View {
  private let store: StoreOf<PingPongGuideFeature>
  
  public init(store: StoreOf<PingPongGuideFeature>) {
    self.store = store
    UINavigationBar.setAnimationsEnabled(false)
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      title
      ZStack(alignment: .bottom) {
        GeometryReader { geometry in
          let width = geometry.size.width
          let firstPingPongWidth = max(width - 70, 0)
          let secondPingPongWidth = max(width - 55, 0)
          HStack(spacing: 0) {
            Spacer()
            VStack(spacing: 10) {
              firstPingPongImage
                .aspectRatio(contentMode: .fit)
                .frame(width: firstPingPongWidth)
                .clipped()
              secondPingPongImage
                .aspectRatio(contentMode: .fit)
                .frame(width: secondPingPongWidth)
                .clipped()
            }
            Spacer()
          }
          .offset(y: 48)
        }
        nextButton
          .padding(.bottom, .lg)
          .background(to: ColorToken.container(.primary))
      }
    }
    .padding(.top, .xl)
    .padding(.horizontal, .md)
    .setNavigationBar {
      makeNaivgationleftButton {
        store.send(.backButtonDidTapped)
      }
    }
  }
}

private extension PingPongGuideView {
  var title: some View {
    TitleView(
      pageInfo: PageInfo(nowPage: 2, totalCount: 4),
      title: "보틀만의 가지관 문답을 통해\n진솔한 모습을 확인할 수 있어요"
    )
  }
  
  var firstPingPongImage: some View {
    BottleImageView(type:
        .local(bottleImageSystem: .illustraition(.firstPingPong))
    )
  }
  
  var secondPingPongImage: some View {
    BottleImageView(type:
        .local(bottleImageSystem: .illustraition(.secondPingPong))
    )
  }
  
  var nextButton: some View {
      SolidButton(
        title: "다음",
        sizeType: .large,
        buttonType: .throttle,
        action: { store.send(.nextButtonDidTapped) }
      )
      .shadow(color: .white, radius: 15, y: -30)
    
  }
}
