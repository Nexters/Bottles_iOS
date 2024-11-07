//
//  IntroductionSetupFeature.swift
//  FeatureProfileSetupInterface
//
//  Created by 임현규 on 8/5/24.
//

import Foundation

import DomainProfileInterface
import DomainProfile

import CoreToastInterface
import CoreLoggerInterface

import CoreToastInterface

import ComposableArchitecture

@Reducer
public struct IntroductionSetupFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action {
    // Web Bridge
    case closeWebView
    case presentToastDidRequired(message: String)
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}

extension IntroductionSetupFeature {
  public init() {
    @Dependency(\.dismiss) var dismiss
    @Dependency(\.toastClient) var toastClient
    
    let reducer = Reduce<State, Action> { state, action in
      @Dependency(\.profileClient) var profileClient
      
      switch action {
      case .closeWebView:
        return .run { _ in
          await dismiss()
        }
        
      case let .presentToastDidRequired(message):
        toastClient.presentToast(message: message)
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
