//
//  ProfileEditView.swift
//  FeatureMyPage
//
//  Created by JongHoon on 9/22/24.
//

import SwiftUI

import FeatureBaseWebViewInterface

import CoreLoggerInterface

import SharedDesignSystem

import ComposableArchitecture

public struct ProfileEditView: View {
  @Perception.Bindable private var store: StoreOf<EditProfileFeature>
  
  public init(store: StoreOf<EditProfileFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      BaseWebView(type: .editProfile) { action in
        switch action {
        case .webViewLoadingDidCompleted:
          store.send(.initialLoadingCompleted)
          
        case let .showTaost(message):
          store.send(.presentToast(message: message))
          
        case .closeWebView:
          store.send(.backButtonDidTapped)
          
        default:
          Log.assertion(message: "\(action) - not handled action")
        }
      }
    }
    .navigationBarBackButtonHidden()
    .overlay {
      WithPerceptionTracking {
        if store.isLoading {
          LoadingIndicator()
        }
      }
    }
    .ignoresSafeArea(.all, edges: [.bottom, .top])
  }
}
