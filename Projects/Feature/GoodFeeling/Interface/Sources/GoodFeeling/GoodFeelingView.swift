//
//  GoodFeelingView.swift
//  FeatureGoodFeelingInterface
//
//  Created by JongHoon on 10/6/24.
//

import SwiftUI

import FeatureBaseWebViewInterface

import CoreLoggerInterface

import SharedDesignSystem

import ComposableArchitecture

public struct GoodFeelingView: View {
  @Perception.Bindable private var store: StoreOf<GoodFeelingFeature>
  
  public init(store: StoreOf<GoodFeelingFeature>) { 
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      BaseWebView(
        type: .goodFeeling,
        actionDidInputted: { action in
          switch action {
          case .webViewLoadingDidCompleted:
            store.send(.webViewLoadingDidCompleted)
            
          case let .openLink(url):
            store.send(.sentBottleTapped(url: url))
            
          default:
            Log.assertion(message: "not handled action: \(action)")
          }
        }
      )
      .overlay {
        if store.isLoading {
          LoadingIndicator()
        }
      }
    }
  }
}
