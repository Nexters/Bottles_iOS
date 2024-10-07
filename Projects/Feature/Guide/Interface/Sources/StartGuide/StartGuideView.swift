//
//  StartGuideView.swift
//  FeatureGuideInterface
//
//  Created by 임현규 on 8/23/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct StartGuideView: View {
  private let store: StoreOf<StartGuideFeature>
  
  public init(store: StoreOf<StartGuideFeature>) {
    self.store = store
    UINavigationBar.setAnimationsEnabled(true)
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      title
      ZStack(alignment: .bottom) {
        GeometryReader { geometry in
          let bottleImageTopPadding: CGFloat = 62.0
          HStack(spacing: 0) {
            Spacer()
            bottleImage
              .scaledToFit()
            Spacer()
          }
          .offset(y: bottleImageTopPadding)
          .padding(.horizontal, 60.0 - BottlePaddingType.md.length)
        }
        doneButton
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

private extension StartGuideView {
  var title: some View {
    TitleView(
      pageInfo: PageInfo(nowPage: 4, totalCount: 4),
      title: "설레는 여정\n보틀과 함께 시작해 볼까요?"
    )
  }
  
  var bottleImage: some View {
    BottleImageView(type:
        .local(bottleImageSystem: .illustraition(.bottle2))
    )
  }
  
  var doneButton: some View {
      SolidButton(
        title: "완료",
        sizeType: .large,
        buttonType: .throttle,
        action: { store.send(.doneButtonDidTapped) }
      )
      .shadow(color: .white, radius: 15, y: -30)
    
  }
}
