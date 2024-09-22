//
//  EditProfileFeatureInterface.swift
//  FeatureMyPage
//
//  Created by JongHoon on 9/22/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct EditProfileFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    var isLoading: Bool
    
    init() {
      self.isLoading = true
    }
  }
  
  public enum Action: BindableAction {
    case initialLoadingCompleted
    case presentToast(message: String)
    case backButtonDidTapped
    case delegate(Delegate)
    
    public enum Delegate {
      case closeEditProfileView
    }
    
    // binding
    case binding(BindingAction<State>)
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    reducer
  }
}
