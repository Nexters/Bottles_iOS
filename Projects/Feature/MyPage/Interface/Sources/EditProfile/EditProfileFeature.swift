//
//  EditProfileFeature.swift
//  FeatureMyPage
//
//  Created by JongHoon on 9/22/24.
//

import Foundation

import CoreToastInterface

import ComposableArchitecture

extension EditProfileFeature {
  public init() {
    @Dependency(\.toastClient) var toastClient
    
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .initialLoadingCompleted:
        state.isLoading = false
        return .none
        
      case let .presentToast(message):
        toastClient.presentToast(message: message)
        return .none
        
      case .backButtonDidTapped:
        return .send(.delegate(.closeEditProfileView))
        
      default:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
