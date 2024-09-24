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
        case let .showTaost(message):
          store.send(.presentToastDidRequired(message: message))
          
        default:
          break
        }
      }
      .overlay {
        if store.isLoading {
          LoadingIndicator()
        }
      }
      .ignoresSafeArea(.all, edges: [.top, .bottom])
      .toolbar(.hidden, for: .navigationBar)
      .toolbar(.hidden, for: .bottomBar)
    }
  }
}
