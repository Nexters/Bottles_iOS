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
      ZStack(alignment: .bottom) {
        GeometryReader { geometry in
          HStack(spacing: 0) {
            Spacer()
            bottleArrivalImage
              .aspectRatio(contentMode: .fill)
              .frame(width: geometry.size.width - 72 > 0 ? geometry.size.width - 72 : 0)
              .clipped()
              .offset(y: 48)
            Spacer()
          }          
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
    .toolbar(.visible, for: .navigationBar)
  }
}

private extension MainGuideView {
  var title: some View {
    TitleView(
      pageInfo: PageInfo(nowPage: 1, totalCount: 4),
      title: "천천히 서로를 알아가는 소개팅\n보틀에 오신 것을 환영해요!"
    )
  }
  
  var bottleArrivalImage: some View {
    BottleImageView(type:
        .local(bottleImageSystem: .illustraition(.bottleArrivalPhone))
    )
    .clipShape(RoundedRectangle(cornerRadius: 30))
    .overlay(
      RoundedRectangle(cornerRadius: 30)
        .strokeBorder(
          ColorToken.text(.primary).color,
          lineWidth: 10
        )
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
