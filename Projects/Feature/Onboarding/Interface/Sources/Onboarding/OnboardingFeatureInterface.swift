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
  
  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action {
    case onAppear
    case presentToastDidRequired(message: String)
    case createProfileDidCompleted
    
    public enum Delegate {
      case createProfileDidCompleted
    }
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}
