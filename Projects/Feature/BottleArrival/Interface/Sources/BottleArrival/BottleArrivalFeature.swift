//
//  BottleArrivalFeature.swift
//  FeatureBottleArrivalInterface
//
//  Created by 임현규 on 8/11/24.
//

import Foundation

import CoreToastInterface

import ComposableArchitecture

extension BottleArrivalFeature {
  public init() {
    @Dependency(\.toastClient) var toastClient
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
        
      case .webViewLoadingDidCompleted:
        state.isLoading = false
        return .none
        
      case let .arrivalBottleTapped(url):
        return .send(.delegate(.arrivalBottleTapped(url: url)))
        
      case .closeWebView:
        return .send(.delegate(.closeWebView))
        
      case let .presentToastDidRequired(message):
        toastClient.presentToast(message: message)
        return .none
        
      default:
        return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
