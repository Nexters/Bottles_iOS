//
//  OnboardingView.swift
//  FeatureOnboarding
//
//  Created by JongHoon on 7/31/24.
//

import SwiftUI
import WebKit

import CoreWebViewInterface
import FeatureBaseWebViewInterface

import ComposableArchitecture

public struct OnboardingView: View {
  private var store: StoreOf<OnboardingFeature>
  
  public init(store: StoreOf<OnboardingFeature>) {
    self.store = store
  }
  
  public var body: some View {
    BaseWebView(
      type: .createProfile,
      actionDidInputted: { action in
        switch action {
        case .closeWebView:
          store.send(.closeButtonDidTap)
        case let .showTaost(message):
          store.send(.presentToastDidRequired(message: message))
        case .createProfileDidCompleted:
          store.send(.createProfileDidCompleted)
        default:
          break
        }
      }
    )
    .ignoresSafeArea()
  }
}
