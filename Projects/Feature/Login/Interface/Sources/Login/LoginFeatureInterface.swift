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
    var isPresentTermView: Bool
    var termURL: String
    
    var path = StackState<Path.State>()
    public init() {
      self.isPresentTermView = false
      self.termURL = ""
    }
  }
  
  public enum Action: BindableAction {
    // View Life Cycle
    case onAppear
    
    case signInKakaoButtonDidTapped
    case signInGeneralButtonDidTapped
    
    case personalInformationTermButtonDidTapped
    case utilizationTermButtonDidTapped
    
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
