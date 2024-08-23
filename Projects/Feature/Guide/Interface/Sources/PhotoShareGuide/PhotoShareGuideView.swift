//
//  PhotoShareGuideView.swift
//  FeatureGuideInterface
//
//  Created by 임현규 on 8/23/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct PhotoShareGuideView: View {
  private let store: StoreOf<PhotoShareGuideFeature>
  
  public init(store: StoreOf<PhotoShareGuideFeature>) {
    self.store = store
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      title
        .padding(.horizontal, .md)
      ZStack(alignment: .bottom) {
        GeometryReader { geometry in
          let width = geometry.size.width
          let photoShareImageWidth = max(width - 100, 0)
          VStack(spacing: 0) {
            HStack(spacing: 0) {
              girlImage
                .aspectRatio(contentMode: .fit)
                .clipped()
              Spacer()
                .frame(width: 12)
              
              boyImage
                .aspectRatio(contentMode: .fit)
                .clipped()
            }
            
            photoShareImage
              .aspectRatio(contentMode: .fit)
              .frame(width: photoShareImageWidth)
              .clipped()
              .offset(y: -85)
          }
          .offset(y: 48)
        }
        nextButton
          .padding(.bottom, .lg)
          .padding(.horizontal, .md)
          .background(to: ColorToken.container(.primary))
      }
    }
    .padding(.top, .xl)
    .setNavigationBar {
      makeNaivgationleftButton {
        store.send(.backButtonDidTapped)
      }
    }
  }
}

private extension PhotoShareGuideView {
  var title: some View {
    TitleView(
      pageInfo: PageInfo(nowPage: 3, totalCount: 4),
      title: "확신이 생겼다면\n사진과 연락처를 주고 받아 보세요"
    )
  }
  
  var girlImage: some View {
    BottleImageView(type:
        .local(bottleImageSystem: .illustraition(.girl))
    )
    .cornerRadius(.md, corenrs: [.topRight])
  }
  
  var boyImage: some View {
    BottleImageView(type:
        .local(bottleImageSystem: .illustraition(.boy))
    )
    .cornerRadius(.md, corenrs: [.topLeft])
  }
  
  var photoShareImage: some View {
    BottleImageView(type:
        .local(bottleImageSystem: .illustraition(.photoShare))
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
