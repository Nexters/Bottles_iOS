//
//  ProfileImageUploadFeature.swift
//  FeatureProfileSetupInterface
//
//  Created by 임현규 on 8/5/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct ProfileImageUploadFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    public var selectedImageData: Data?
    public var isDisableDoneButton: Bool = true
    public init() {}
  }
  
  public enum Action {
    case onAppear
    case doneButtonDidTapped
    case imageDidSelected(selectedImageData: Data)
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}

extension ProfileImageUploadFeature {
  public init() {
    let reducer = Reduce<State, Action> { state, action in
    
      switch action {
      case .onAppear:
        return .none
      case .doneButtonDidTapped:
        return .none
      case let .imageDidSelected(selectedImageData):
        state.selectedImageData = selectedImageData
        state.isDisableDoneButton = false
        return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
