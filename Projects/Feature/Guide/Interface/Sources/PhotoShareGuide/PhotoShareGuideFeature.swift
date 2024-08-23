//
//  PhotoShareGuideFeature.swift
//  FeatureGuideInterface
//
//  Created by 임현규 on 8/23/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct PhotoShareGuideFeature {
  private let reducer: Reduce<State, Action>
  
  init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action {
    
    // User Action
    case nextButtonDidTapped
    case backButtonDidTapped
    
    // Delegate
    case delegate(Delegate)
    
    public enum Delegate {
      case nextButtonDidTapped
    }
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}

extension PhotoShareGuideFeature {
  public init() {
    @Dependency(\.dismiss) var dismiss
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .nextButtonDidTapped:
        return .send(.delegate(.nextButtonDidTapped))
        
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
