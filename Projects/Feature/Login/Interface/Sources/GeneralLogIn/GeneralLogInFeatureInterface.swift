//
//  GeneralLogInFeatureInterface.swift
//  FeatureLoginInterface
//
//  Created by JongHoon on 8/4/24.
//

import Foundation

import DomainAuthInterface

import ComposableArchitecture

@Reducer
public struct GeneralLogInFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    var isShowLoadingProgressView: Bool
    
    public init() {
      self.isShowLoadingProgressView = true
    }
  }
  
  public enum Action: BindableAction {
    // View Life Cycle
    case onAppear
    
    case webViewLoadingDidCompleted
    case presentToastDidRequired(message: String)
    case loginDidCompleted(
      accessToken: String,
      refreshToken: String,
      isCompletedOnboardingIntroduction: Bool
    )
    case closeButtonDidTapped
    
    // ETC
    case binding(BindingAction<State>)
    
    // Delegate
    case delegate(Delegate)
    
    public enum Delegate {
      case generalLogInDidSucess(UserInfo)
    }
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}
