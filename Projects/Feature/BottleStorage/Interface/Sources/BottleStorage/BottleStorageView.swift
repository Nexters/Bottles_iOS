//
//  BottleStorageView.swift
//  FeatureBottleStorage
//
//  Created by JongHoon on 7/25/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct BottleStorageView: View {
  @Perception.Bindable private var store: StoreOf<BottleStorageFeature>
  
  public init(store: StoreOf<BottleStorageFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
        VStack(spacing: 0.0) {
          bottleActiveStateSelectTab
          
          bottlsList
            .padding(.horizontal, .md)
            .padding(.top, 32.0)
            .padding(.bottom, 36.0)
        }
        .frame(maxHeight: .infinity, alignment: .top)
      } destination: { store in
        WithPerceptionTracking {
          switch store.state {
          case .pingPongDetail:
            if let store = store.scope(state: \.pingPongDetail, action: \.pingPongDetail) {
              PingPongDetailView(store: store)
            }
          }
        }
      }
      .onAppear {
        store.send(.onAppear)
      }
    }
  }
}

// MARK: - Private Views

private extension BottleStorageView {
  var bottleActiveStateSelectTab: some View {
    HStack(spacing: .xs) {
      OutlinedStyleButton(
        .small(contentType: .text),
        title: BottleActiveState.active.title,
        buttonType: .throttle,
        isSelected: store.selectedActiveStateTab == BottleActiveState.active,
        action: {
          store.send(.bottleActiveStateTabButtonTapped(.active))
        }
      )
      
      OutlinedStyleButton(
        .small(contentType: .text),
        title: BottleActiveState.done.title,
        buttonType: .throttle,
        isSelected: store.selectedActiveStateTab == BottleActiveState.done,
        action: {
          store.send(.bottleActiveStateTabButtonTapped(.done))
        }
      )
      
      Spacer()
    }
    .padding(.md)
  }
  
  @ViewBuilder
  var bottlsList: some View {
    if store.currentSelectedBottles.isEmpty && store.activeBottleList != nil {
      VStack(spacing: .xxl) {
        HStack(spacing: 0.0) {
          WantedSansStyleText(
            "아직 보관 중인\n보틀이 없어요!",
            style: .title1,
            color: .primary
          )
          
          Spacer()
        }
        
        Image(systemName: "photo")
          .resizable()
          .frame(width: 180.0, height: 180.0)
      }
    } else {
      ScrollView {
        VStack(spacing: .md) {
          ForEach(store.currentSelectedBottles, id: \.id) { bottle in
            BottleStorageItem(
              userName: bottle.userName ?? "(없음)",
              age: bottle.age ?? 0,
              mbti: bottle.mbti,
              keywords: bottle.keyword,
              imageURL: bottle.userImageUrl,
              isRead: bottle.isRead ?? false
            )
            .asButton {
              store.send(.bottleStorageItemDidTapped(bottleID: bottle.id, userName: bottle.userName ?? ""))
            }
          }
        }
      }
      .scrollIndicators(.hidden)
    }
  }
}
