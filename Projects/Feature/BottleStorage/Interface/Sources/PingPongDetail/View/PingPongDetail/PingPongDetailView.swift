//
//  PingPongDetail.swift
//  FeatureBottleStorageInterface
//
//  Created by JongHoon on 8/10/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct PingPongDetailView: View {
  @Perception.Bindable private var store: StoreOf<PingPongDetailFeature>
  
  public init(store: StoreOf<PingPongDetailFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      VStack(alignment: .leading, spacing: 0.0) {
        tabButtons
          switch store.selectedTab {
          case .introduction:
            IntroductionView(store: store.scope(state: \.introduction, action: \.introduction))
            
          case .questionAndAnswer:
            QuestionAndAnswerView(store: store.scope(state: \.questionAndAnswer, action: \.questionAndAnswer))
            
          case .matching:
            MatchingView(store: store.scope(state: \.matching, action: \.matching))
        }
      }
    }
  }
}

private extension PingPongDetailView {
  var tabButtons: some View {
    HStack(spacing: .xs) {
      ForEach(PingPongDetailViewTabType.allCases, id: \.title, content: { tab in
        OutlinedStyleButton(
          .small(contentType: .text),
          title: tab.title,
          buttonType: .throttle,
          isSelected: store.selectedTab == tab,
          action: { store.send(.pingPongDetailViewTabDidTapped(tab)) }
        )
      })
      
      Spacer()
    }
    .padding(.sm)
    .frame(maxWidth: .infinity)
  }
}
