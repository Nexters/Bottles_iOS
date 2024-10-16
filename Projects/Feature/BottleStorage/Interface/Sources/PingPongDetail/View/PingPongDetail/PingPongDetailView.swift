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
      .onLoad {
        store.send(.onLoad)
      }
    }
    .setNavigationBar(
      leftView: {
        makeNaivgationleftButton {
          store.send(.backButtonDidTapped)
        }
      }, centerView: {
        WantedSansStyleText(
                  store.userName,
                  style: .body,
                  color: .secondary
                )
      }, rightView: {
        makeNavigationReportButton {
          store.send(.reportButtonDidTapped)
        }
      }
    )
    .ignoresSafeArea(.all, edges: .bottom)
    .bottleAlert($store.scope(state: \.destination?.alert, action: \.destination.alert))
  }
}

private extension PingPongDetailView {
  var tabButtons: some View {
    HStack(spacing: .xs) {
      ForEach(PingPongDetailViewTabType.allCases, id: \.title, content: { tab in
        SegmentControlButton(
          title: tab.title,
          buttonType: .throttle,
          isSelected: store.selectedTab == tab,
          action: { store.send(.pingPongDetailViewTabDidTapped(tab)) }
        )
        .disabled(tab == .matching && store.isMatchingTabDisabled)
      })
      
      Spacer()
    }
    .padding(.sm)
    .frame(maxWidth: .infinity)
    .background(to: ColorToken.background(.primary))
  }
}
