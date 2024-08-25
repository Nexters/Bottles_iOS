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
    var isLoading: Bool
    
    var path = StackState<Path.State>()
    public init() {
      self.isPresentTermView = false
      self.termURL = ""
      self.isLoading = false
    }
  }
  
  public enum Action: BindableAction {
    // View Life Cycle
    case onAppear
    
    // User Action
    case signInKakaoButtonDidTapped
    case signInGeneralButtonDidTapped
    case signInAppleButtonDidTapped
    case snsLoginButtonDidTapped
    
    case personalInformationTermButtonDidTapped
    case utilizationTermButtonDidTapped
    
    case guideDidCompleted
    case indicatorStateChanged(isLoading: Bool)
    case socialLoginDidSuccess(UserInfo)
    case signUpCheckCompleted(isSignUp: Bool)
    case goToMainTab
    case goToGeneralLogin
    case userProfileFetchRequired(userName: String)
    case userProfileFetchDiduccess
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
