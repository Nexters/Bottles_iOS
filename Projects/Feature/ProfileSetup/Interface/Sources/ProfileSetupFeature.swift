//
//  ProfileSetupFeature.swift
//  FeatureProfileSetupInterface
//
//  Created by 임현규 on 8/5/24.
//

import Foundation

import DomainProfileInterface

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
    public var keywordItem: [ClipItem] = []
    public var isNextButtonDisable: Bool = true
    public init() {}
  }
  
  public enum Action: BindableAction {
    case onAppear
    case texFieldDidFocused(isFocused: Bool)
    case binding(BindingAction<State>)
    case setKeyworkItem(UserProfile)
    case nextButtonDidTapped
    case onTapGesture
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    reducer
  }
}
