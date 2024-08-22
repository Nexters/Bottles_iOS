//
//  IntroductionView.swift
//  FeatureBottleStorage
//
//  Created by JongHoon on 8/11/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct IntroductionView: View {
  @Perception.Bindable private var store: StoreOf<IntroductionFeature>
  
  public init(store: StoreOf<IntroductionFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      ScrollView {
        VStack(spacing: 0.0) {
          if store.isStopped == true {
            StopCardView(userName: store.userName)
          } else if store.isStopped == false {
            UserProfileView(
              imageURL: store.userImageURL,
              isBlurred: true,
              userName: store.userName,
              userAge: store.age
            )
            
            Spacer()
              .frame(height: 24.0)
            
            LettetCardView(
              title: "\(store.userName)님이 보내는 편지",
              letterContent: store.introduction
            )
          }
          
          Spacer()
            .frame(height: 12.0)
          
          ClipListContainerView(
            clipItemList: [
              .init(
                title: "기본 정보",
                list: store.basicInfos
              ),
              .init(
                title: "나의 성격은",
                list: store.characterInfos
              ),
              .init(
                title: "내가 푹 빠진 취미는",
                list: store.hobyInfos
              )
            ]
          )
          
          Spacer()
            .frame(height: 24.0)
          
          WantedSansStyleText(
            "대화 중단하기",
            style: .subTitle2,
            color: .enableSecondary
          )
          .asThrottleButton {
            store.send(.stopTaskButtonTapped)
          }
          .disabled(store.isStopped == true)
          
          Spacer()
            .frame(height: 30)
        }
        .padding(.horizontal, 16.0)
        .padding(.top, 32.0)
      }
      .scrollIndicators(.hidden)
      .alert($store.scope(state: \.destination?.alert, action: \.destination.alert))
      .background(to: ColorToken.background(.primary))
      
    }
  }
}
