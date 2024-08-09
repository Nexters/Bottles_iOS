//
//  LoginFeatureInterface.swift
//  FeatureLogin
//
//  Created by JongHoon on 7/24/24.
//

import Foundation

import CoreLoggerInterface
import CoreNetwork
import DomainAuth
import DomainAuthInterface
import ComposableArchitecture
import KakaoSDKCommon

@Reducer
public struct LoginFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    var path = StackState<Path.State>()
    public init() {}
  }
  
  public enum Action: BindableAction {
    case onAppear
    case signInKakaoButtonDidTapped
    case signInKakaoDidSuccess(UserInfo)
    case signUpCheckCompleted(isSignUp: Bool)
    case goToMainTab
    case goToGeneralLogin
    case path(StackAction<Path.State, Path.Action>)
    case binding(BindingAction<State>)
    case delegate(Delegate)
    
    public enum Delegate {
      case createOnboardingProfileDidCompleted
    }
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    reducer
      .forEach(\.path, action: \.path)
  }
}
