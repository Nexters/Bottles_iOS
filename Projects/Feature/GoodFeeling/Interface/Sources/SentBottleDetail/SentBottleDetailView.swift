//
//  SentBottleDetailView.swift
//  FeatureGoodFeeling
//
//  Created by JongHoon on 10/9/24.
//

import SwiftUI

import FeatureBaseWebViewInterface

import CoreLoggerInterface

import SharedDesignSystem

import ComposableArchitecture

public struct SentBottleDetailView: View {
  @Perception.Bindable private var store: StoreOf<SentBottleDetailFeature>
  
  public init(store: StoreOf<SentBottleDetailFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      BaseWebView(
        type: .openURL(url: store.sentBottleDetailURL),
        actionDidInputted: { action in
          switch action {
          case .webViewLoadingDidCompleted:
            store.send(.webViewLoadingDidCompleted)
            
          case .closeWebView:
            store.send(.backButtonDidTapped)
            
          case let .showTaost(message):
            store.send(.showToast(message: message))
          
          case .bottelDidAccepted:
            store.send(.bottelDidAccepted)
            
          default:
            Log.assertion(message: "not handled action: \(action)")
          }
        }
      )
      .navigationBarBackButtonHidden()
      .ignoresSafeArea(.all, edges: [.top, .bottom])
      .overlay {
        if store.isLoading {
          LoadingIndicator()
        }
      }
    }
  }
}
