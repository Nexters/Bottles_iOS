//
//  GeneralLogInView.swift
//  FeatureLoginInterface
//
//  Created by JongHoon on 8/4/24.
//

import SwiftUI

import SharedDesignSystem
import FeatureBaseWebViewInterface

import ComposableArchitecture

public struct GeneralLogInView: View {
  private let store: StoreOf<GeneralLogInFeature>
  
  public init(store: StoreOf<GeneralLogInFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      BaseWebView(
        type: BottleWebViewType.login,
        actionDidInputted: { action in
          switch action {
          case .webViewLoadingDidCompleted:
            store.send(.webViewLoadingDidCompleted)
            
          case let .showTaost(message):
            store.send(.presentToastDidRequired(message: message))
            
          case let .loginDidCompleted(accessToken, refreshToken, isCompletedOnboardingIntroduction):
            store.send(.loginDidCompleted(
              accessToken: accessToken,
              refreshToken: refreshToken,
              isCompletedOnboardingIntroduction: isCompletedOnboardingIntroduction
            ))
            
          case .closeWebView:
            store.send(.closeButtonDidTapped)
            
          default:
            break
          }
        }
      )
      .overlay {
        if store.isShowLoadingProgressView {
          LoadingIndicator()
        }
      }
      .ignoresSafeArea(.all, edges: [.top, .bottom])
      .toolbar(.hidden, for: .navigationBar)
    }
  }
}
