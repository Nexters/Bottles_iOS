//
//  MyPageFeature.swift
//  FeatureMyPageInterface
//
//  Created by JongHoon on 7/24/24.
//

import Foundation

import FeatureMyPageInterface

import ComposableArchitecture

extension MyPageFeature {
  public init() {
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
        
      case let .presentToastRequired(message):
        // TODO: present toast
        return .none
        
      case .logOutDidCompleted:
        // TODO: log out handling
        return .none
        
      case .withdrawalDidCompleted:
        // TODO: withdarawal completed handling
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}

