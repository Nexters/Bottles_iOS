//
//  GeneralSignUpFeatureInterface.swift
//  FeatureGeneralSignUpInterface
//
//  Created by JongHoon on 8/4/24.
//

import Foundation

import DomainAuthInterface

import ComposableArchitecture

@Reducer
public struct GeneralSignUpFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    var isShowLoadingProgressView: Bool
    
    public init() {
      isShowLoadingProgressView = true
    }
  }
  
  public enum Action: BindableAction {
    // View Life Cycle
    case onAppear
    
    case webViewLoadingDidCompleted
    case closeButtonDidTap
    case presentToastDidRequired(message: String)
    case signUpDidCompleted(accessToken: String, refreshToken: String)
    
    // ETC
    case binding(BindingAction<State>)
    
    // Delegate
    case delegate(Delegate)
    
    public enum Delegate {
      case signUpDidCompleted(UserInfo)
    }
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    reducer
  }
}
