//
//  BottleArrivalDetailView.swift
//  FeatureBottleArrival
//
//  Created by JongHoon on 10/9/24.
//

import SwiftUI

import FeatureBaseWebViewInterface

import CoreLoggerInterface

import ComposableArchitecture

public struct BottleArrivalDetailView: View {
  @Perception.Bindable private var store: StoreOf<BottleArrivalDetailFeature>
  
  public init(store: StoreOf<BottleArrivalDetailFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      BaseWebView(
        type: .openURL(url: store.bottleArrivalURL),
        actionDidInputted: { action in
          switch action {
          case .webViewLoadingDidCompleted:
            break
            
          case .closeWebView:
            store.send(.backButtonDidTapped)
            
          case let .showTaost(message):
            store.send(.showToast(message: message))
            
          default:
            Log.assertion(message: "not handled action: \(action)")
          }
        }
      )
      .navigationBarBackButtonHidden()
      .ignoresSafeArea(.all, edges: .bottom)
    }
  }
}

