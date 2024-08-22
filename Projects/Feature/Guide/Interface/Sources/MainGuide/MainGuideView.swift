//
//  MainGuideView.swift
//  FeatureGuideInterface
//
//  Created by 임현규 on 8/22/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct MainGuideView: View {
  private let store: StoreOf<MainGuideFeature>
  
  public init(store: StoreOf<MainGuideFeature>) {
    self.store = store
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      title
      Spacer()
      bottleArrivalImage
      nextButton
      
      
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

private extension MainGuideView {
  var title: some View {
    TitleView(
      pageInfo: PageInfo(nowPage: 1, totalCount: 4),
      title: "천천히 서로를 알아가는 소개팅\n보틀에 오신 것을 환영해요"
    )
  }
  
  var bottleArrivalImage: some View {
    BottleImageView(type:
        .local(bottleImageSystem: .illustraition(.bottleArrivalPhone))
    )
    .clipShape(RoundedRectangle(cornerRadius: BottleRadiusType.xl.value))
    .overlay(
      RoundedRectangle(cornerRadius: BottleRadiusType.xl.value)
        .strokeBorder(
          ColorToken.text(.primary).color,
          lineWidth: 10
        )
    )
    .frame(maxWidth: .infinity)
    .ignoresSafeArea(.all, edges: .bottom)
    .padding(.horizontal, 62 - 20)
    .aspectRatio(contentMode: .fit)
    .padding(.top, 48)
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
