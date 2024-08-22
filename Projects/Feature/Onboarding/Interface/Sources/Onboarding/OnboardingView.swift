//
//  OnboardingView.swift
//  FeatureOnboarding
//
//  Created by JongHoon on 7/31/24.
//

import SwiftUI
import WebKit

import CoreLoggerInterface
import CoreWebViewInterface
import SharedDesignSystem
import FeatureBaseWebViewInterface

import ComposableArchitecture

public struct OnboardingView: View {
  private var store: StoreOf<OnboardingFeature>
  
  public init(store: StoreOf<OnboardingFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      BaseWebView(
        type: .createProfile,
        actionDidInputted: { action in
          switch action {
          case .webViewLoadingDidCompleted:
            store.send(.webViewLoadingCompleted)
            
          case let .showTaost(message):
            store.send(.presentToastDidRequired(message: message))
            
          case .createProfileDidCompleted:
            store.send(.createProfileDidCompleted)
            
          default:
            Log.assertion(message: "not handled web view action")
            break
          }
        }
      )
      .ignoresSafeArea(.all, edges: .bottom)
      .toolbar(.hidden, for: .navigationBar)
      .overlay {
        if store.isShowLoadingProgressView {
          LoadingIndicator()
        }
      }
    }
  }
}
