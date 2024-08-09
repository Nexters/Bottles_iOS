//
//  OnboardingFeatureInterface.swift
//  FeatureOnboarding
//
//  Created by JongHoon on 7/31/24.
//

import Foundation

import CoreWebViewInterface

import ComposableArchitecture

@Reducer
public struct OnboardingFeature {
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
    case onAppear
    case presentToastDidRequired(message: String)
    case createProfileDidCompleted
    case webViewLoadingCompleted
    case delegate(Delegate)
    
    case binding(BindingAction<State>)
    
    public enum Delegate {
      case createOnboardingProfileDidCompleted
    }
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}
