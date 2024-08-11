//
//  BottleArrivalView.swift
//  FeatureBottleArrivalInterface
//
//  Created by 임현규 on 8/11/24.
//

import SwiftUI

import SharedDesignSystem
import FeatureBaseWebViewInterface

import ComposableArchitecture

public struct BottleArrivalView: View {
  private let store: StoreOf<BottleArrivalFeature>
  @State private var isVisibleTabBar: Bool = true

  public init(store: StoreOf<BottleArrivalFeature>) {
    self.store = store
  }
  
  public var body: some View {

    WithPerceptionTracking {
      BaseWebView(
        type: .bottles) { action in
        switch action {
        case .webViewLoadingDidCompleted:
          store.send(.webViewLoadingDidCompleted)
        case .bottelDidAccepted:
          store.send(.bottelDidAccepted)
        case .closeWebView:
          store.send(.closeWebView)
        default:
          break
        }
      }
      .overlay {
        if store.isLoading {
          LoadingIndicator()
        }
      }
      .onLoad {
        isVisibleTabBar.toggle()
      }
      .ignoresSafeArea(.all, edges: .bottom)
      .toolbar(.hidden, for: .navigationBar)
      .toolbar(isVisibleTabBar ? .visible : .hidden, for: .tabBar)
      .animation(.easeInOut, value: isVisibleTabBar)

    }
  }
}
