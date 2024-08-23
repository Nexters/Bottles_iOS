//
//  AppleLoginFeature.swift
//  FeatureLoginInterface
//
//  Created by 임현규 on 8/23/24.
//

import Foundation

import ComposableArchitecture

extension AppleLoginFeature {
  public init() {
    @Dependency(\.dismiss) var dismiss
    
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .signInAppleButtonDidTapped:
        return .send(.delegate(.signInAppleButtonDidTapped))
       
      case .backButtonDidTapped:
        return .run { send in
          await dismiss()
        }
        
      default:
        return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
