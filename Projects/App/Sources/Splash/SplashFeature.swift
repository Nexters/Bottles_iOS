//
//  SplashFeature.swift
//  Bottle
//
//  Created by JongHoon on 7/21/24.
//

import Foundation

import CoreUtil
import Feature

import ComposableArchitecture

@Reducer
public struct SplashFeature {
  private let rootViewChanger = RootViewChanger()
  
  public struct State: Equatable {
  }
  
  public enum Action {
    case viewLoaded
  }
  
  public var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .viewLoaded:
        return .run { _ in
          try await Task.sleep(nanoseconds: 2500_000_000)
          rootViewChanger.changeRootView(rootView: .tabView)
        }
      }
    }
  }
}
