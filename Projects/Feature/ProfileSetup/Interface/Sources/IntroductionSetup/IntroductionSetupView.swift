//
//  IntroductionSetupView.swift
//  FeatureProfileSetupInterface
//
//  Created by 임현규 on 8/5/24.
//

import SwiftUI

import FeatureBaseWebViewInterface

import CoreLoggerInterface

import SharedDesignSystem

import ComposableArchitecture

public struct IntroductionSetupView: View {
  @Perception.Bindable private var store: StoreOf<IntroductionSetupFeature>
  @FocusState private var isTextFieldFocused: Bool
  
  public init(store: StoreOf<IntroductionSetupFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      BaseWebView(type: .introductionSetup) { action in
        switch action {
        case .webViewLoadingDidCompleted:
          break
    
        case .closeWebView:
          store.send(.closeWebView)
          
        case .introductionDidCompleted:
          store.send(.closeWebView)
          
        case let .showTaost(message):
          store.send(.presentToastDidRequired(message: message))
          
        default:
          Log.assertion(message: "not handled action: \(action)")
        }
      }
    }
    .scrollIndicators(.hidden)
    .ignoresSafeArea(.all, edges: [.bottom, .top])
    .toolbar(.hidden, for: .bottomBar)
    .toolbar(.hidden, for: .navigationBar)
  }
}
