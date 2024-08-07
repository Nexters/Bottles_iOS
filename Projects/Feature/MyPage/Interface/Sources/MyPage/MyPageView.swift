//
//  MyPageView.swift
//  FeatureMyPageInterface
//
//  Created by JongHoon on 7/24/24.
//

import SwiftUI

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
          case let .showTaost(message):
            store.send(.presentToastRequired(message: message))
          case .logOutDidCompleted:
            store.send(.logOutDidCompleted)
          case .withdrawalButtonDidTap:
            store.send(.withdrawalButtonDidTap)
          default:
            break
          }
        }
      )
      .ignoresSafeArea()
    }
  }
}
