//
//  ProfileSetupFeature.swift
//  FeatureProfileSetupInterface
//
//  Created by 임현규 on 8/5/24.
//

import Foundation

import SharedDesignSystem

import ComposableArchitecture

@Reducer
public struct ProfileSetupFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    public var introductionText: String = ""
    public var textFieldState: TextFieldState = .enabled

    public init() {}
  }
  
  public enum Action: BindableAction {
    case onAppear
    case texFieldDidFocused(isFocused: Bool)
    case binding(BindingAction<State>)
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    reducer
  }
}
