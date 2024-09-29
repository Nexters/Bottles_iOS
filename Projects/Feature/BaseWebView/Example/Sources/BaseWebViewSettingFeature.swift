//
//  BaseWebViewSettingFeature.swift
//  FeatureBaseWebViewExample
//
//  Created by 임현규 on 9/29/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct BaseWebViewSettingFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    var path: String
    
    init(path: String = "") {
      self.path = path
    }
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    
    case karinaButtonDidTapped
    case unwooButtonDidTapped
    case openWebViewButtonDidTapped
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    reducer
  }
}

extension BaseWebViewSettingFeature {
  public init() {
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .karinaButtonDidTapped:
        return .none
        
      case .unwooButtonDidTapped:
        return .none
        
      case .openWebViewButtonDidTapped:
        return .none
        
      default:
        return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
