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
    var termsURL: String?
    var isPresentTerms: Bool
    
    public init() {
      isShowLoadingProgressView = true
      self.isPresentTerms = false
    }
  }
  
  public enum Action: BindableAction {
    // View Life Cycle
    case onAppear
    
    case webViewLoadingDidCompleted
    case closeButtonDidTap
    case presentToastDidRequired(message: String)
    case openURLDidRequired(url: String)
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
