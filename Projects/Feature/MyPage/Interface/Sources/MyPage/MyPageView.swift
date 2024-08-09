//
//  MyPageView.swift
//  FeatureMyPageInterface
//
//  Created by JongHoon on 7/24/24.
//

import SwiftUI

import SharedDesignSystem
import FeatureBaseWebViewInterface

import ComposableArchitecture

public struct MyPageView: View {
  private let store: StoreOf<MyPageFeature>
  
  public init(store: StoreOf<MyPageFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      BaseWebView(
        type: .myPage,
        isScrollEnabled: true,
        actionDidInputted: { action in
          switch action {
          case .webViewLoadingDidCompleted:
            store.send(.webViewLoadingDidCompleted)
            
          case let .showTaost(message):
            store.send(.presentToastDidRequired(message: message))
            
          case .logOutButtonDidTapped:
            store.send(.logOutButtonDidTapped)
            
          case .withdrawalButtonDidTap:
            store.send(.withdrawalButtonDidTapped)
            
          default:
            break
          }
        }
      )
      .ignoresSafeArea()
      .overlay {
        if store.isShowLoadingProgressView {
          LoadingIndicator()
        }
      }
    }
  }
}
