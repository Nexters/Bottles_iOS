//
//  BottleStorageView.swift
//  FeatureBottleStorage
//
//  Created by JongHoon on 7/25/24.
//

import SwiftUI

import SharedDesignSystem
import FeatureReportInterface
import FeatureTabBarInterface
import FeatureBottleArrivalInterface

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
          bottlsList
            .padding(.horizontal, .md)
            .padding(.top, 32.0)
        }
        .padding(.top, 72)
        .frame(maxHeight: .infinity, alignment: .top)
        .background(to: ColorToken.background(.primary))
        .padding(.bottom, BottleConstants.bottomTabBarHeight.value)
        .setTabBar(selectedTab: .bottleStorage) { selectedTab in
          store.send(.selectedTabDidChanged(selectedTab: selectedTab))
        }
        .overlay {
          if store.pingPongBottleList.isEmpty && store.isLoading {
            LoadingIndicator()
          }
        }
      } destination: { store in
        WithPerceptionTracking {
          switch store.state {
          case .pingPongDetail:
            if let store = store.scope(
              state: \.pingPongDetail,
              action: \.pingPongDetail) {
              PingPongDetailView(store: store)
            }
          case .report:
            if let store = store.scope(
              state: \.report,
              action: \.report) {
              ReportUserView(store: store)
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
  @ViewBuilder
  var bottlsList: some View {
    if store.pingPongBottleList.isEmpty && !store.isLoading {
      VStack(alignment: .center, spacing: 0.0) {
        
        Spacer()
        BottleImageView(type: .local(bottleImageSystem: .illustraition(.basket)))
          .frame(height: 180)
          .frame(width: 180)
          .aspectRatio(1.0, contentMode: .fit)
          .padding(.bottom, .xl)
        
          WantedSansStyleText(
            "아직 대화를 시작하지 않으셨군요!",
            style: .subTitle1,
            color: .primary
          )
          .padding(.bottom, .xs)
        
          WantedSansStyleText(
            "마음에 드는 상대를 찾아\n가치관 문답을 시작해 볼까요?",
            style: .body,
            color: .tertiary
          )
          .lineSpacing(5)
          .multilineTextAlignment(.center)
          .padding(.bottom, .xl)
        
        SolidButton(title: "모래사장 바로가기", sizeType: .extraSmall, buttonType: .throttle, action: { store.send(.sandBeachButtonDidTapped) })
        
        Spacer()
        }
    } else {
      ScrollView {
        VStack(spacing: .md) {
          ForEach(store.pingPongBottleList, id: \.id) { bottle in
            PingPongUserView(
              status: bottle.lastStatus?.title ?? "",
              lastPingPongTime: bottle.lastActivatedAt ?? "",
              userName: bottle.userName ?? "(없음)",
              age: bottle.age ?? 0,
              mbti: bottle.mbti,
              imageURL: bottle.userImageUrl,
              isRead: bottle.isRead
            )
            .asButton {
              store.send(.bottleStorageItemDidTapped(
                bottleID: bottle.id,
                isRead: bottle.isRead,
                userName: bottle.userName ?? ""
              ))
            }
          }
        }
        
        Spacer()
          .frame(height: 36.0)
      }
      .scrollIndicators(.hidden)
    }
  }
}
