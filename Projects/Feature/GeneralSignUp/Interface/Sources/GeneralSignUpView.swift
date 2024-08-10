//
//  GeneralSignUpView.swift
//  FeatureGeneralSignUpInterface
//
//  Created by JongHoon on 8/4/24.
//

import SwiftUI

import SharedDesignSystem
import FeatureBaseWebViewInterface

import ComposableArchitecture

public struct GeneralSignUpView: View {
  private let store: StoreOf<GeneralSignUpFeature>
  
  public init(store: StoreOf<GeneralSignUpFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      BaseWebView(
        type: .signUp,
        actionDidInputted: { action in
          switch action {
          case .webViewLoadingDidCompleted:
            store.send(.webViewLoadingDidCompleted)
            
          case .closeWebView:
            store.send(.closeButtonDidTap)
            
          case let .showTaost(message):
            store.send(.presentToastDidRequired(message: message))
            
          case let .signUpDidComplted(accessToken, refreshToken):
            store.send(.signUpDidCompleted(
              accessToken: accessToken,
              refreshToken: refreshToken
            ))
            
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
      .toolbar(.hidden, for: .navigationBar)
      .ignoresSafeArea(.all, edges: .bottom)
    }
  }
}
