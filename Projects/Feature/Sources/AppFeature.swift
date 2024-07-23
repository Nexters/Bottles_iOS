//
//  AppFeature.swift
//  Feature
//
//  Created by JongHoon on 7/23/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct AppFeature {
  public struct State: Equatable {
    public var appDelegate: AppDelegateFeature.State
    
    public init() {
      self.appDelegate = .init()
    }
  }
  
  public enum Action {
    case onAppear
    case appDelegate(AppDelegateFeature.Action)
  }
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Reduce(feature)
  }
  
  private func feature(
    state: inout State,
    action: Action
  ) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      return .none
      
    case .appDelegate(_):
      return .none
    }
  }
}


