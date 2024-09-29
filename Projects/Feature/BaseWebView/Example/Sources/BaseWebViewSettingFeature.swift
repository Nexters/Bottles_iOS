//
//  BaseWebViewSettingFeature.swift
//  FeatureBaseWebViewExample
//
//  Created by 임현규 on 9/29/24.
//

import Foundation

import DomainAuth

import ComposableArchitecture

@Reducer
public struct BaseWebViewSettingFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    var path = StackState<Path.State>()
    var urlPath: String
    
    init(urlPath: String = "") {
      self.urlPath = urlPath
    }
  }
  
  public enum Action: BindableAction {
    case path(StackAction<Path.State, Path.Action>)
    case binding(BindingAction<State>)
    
    case karinaButtonDidTapped
    case unwooButtonDidTapped
    case openWebViewButtonDidTapped
  }
  
  @Reducer(state: .equatable)
  public enum Path {
    case webViewTest(BaseWebViewTestFeature)
  }
  public var body: some ReducerOf<Self> {
    BindingReducer()
    reducer
      .forEach(\.path, action: \.path)
  }
}

extension BaseWebViewSettingFeature {
  public init() {
    @Dependency(\.authClient) var authClient
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .karinaButtonDidTapped:
        return .run { send in
          try await authClient.fetchKarinaToken()
        }
        
      case .unwooButtonDidTapped:
        return .run { send in
          try await authClient.fetchUnWooToken()
        }
        
      case .openWebViewButtonDidTapped:
        state.path.append(.webViewTest(.init(urlPath: state.urlPath)))
        
        return .none
        
      default:
        return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
