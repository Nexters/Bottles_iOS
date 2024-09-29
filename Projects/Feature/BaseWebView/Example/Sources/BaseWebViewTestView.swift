//
//  BaseWebViewTestView.swift
//  FeatureBaseWebViewExample
//
//  Created by 임현규 on 9/29/24.
//

import SwiftUI

import FeatureBaseWebViewInterface

import CoreLoggerInterface

import ComposableArchitecture

public struct BaseWebViewTestView: View {
  public var store: StoreOf<BaseWebViewTestFeature>
  
  public init(store: StoreOf<BaseWebViewTestFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      BaseWebView(type: store.webViewResource) { action in
        switch action {
        case .closeWebView:
          store.send(.closeWebView)
          
        default:
          Log.debug(action)
        }
      }
      .ignoresSafeArea(.all, edges: [.bottom, .top])
      .toolbar(.hidden, for: .navigationBar)
      .toolbar(.hidden, for: .bottomBar)
    }
  }
}
