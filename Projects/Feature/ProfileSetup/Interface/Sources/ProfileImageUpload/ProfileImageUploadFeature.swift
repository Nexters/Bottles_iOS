//
//  ProfileImageUploadFeature.swift
//  FeatureProfileSetupInterface
//
//  Created by 임현규 on 8/5/24.
//

import Foundation

import CoreLoggerInterface

import ComposableArchitecture

@Reducer
public struct ProfileImageUploadFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    public var selectedImageData: Data
    public var isDisableDoneButton: Bool
    
    public init(
      selectedImageData: Data = .init(),
      isDisableDoneButton: Bool = true
    ) {
      self.selectedImageData = selectedImageData
      self.isDisableDoneButton = isDisableDoneButton
    }
  }
  
  public enum Action {
    // View Life Cycle
    case onAppear
    
    // User Action
    case doneButtonDidTapped
    case imageDidSelected(selectedImageData: Data)
    case imageDeleteButtonDidTapped
    case backButtonDidTapped
    
    // Delegate
    case delegate(Delegate)
    
    public enum Delegate {
      case doneButtonDidTapped(selectedImageData: Data)
    }
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}

extension ProfileImageUploadFeature {
  public init() {
    let reducer = Reduce<State, Action> { state, action in
      @Dependency(\.dismiss) var dismiss
      
      switch action {
      case .onAppear:
        return .none
      case .doneButtonDidTapped:
        return .run { [imageData = state.selectedImageData] send in
          await send(.delegate(.doneButtonDidTapped(selectedImageData: imageData)))
        }
      case let .imageDidSelected(selectedImageData):
        state.selectedImageData = selectedImageData
        state.isDisableDoneButton = false
        return .none
        
      case .imageDeleteButtonDidTapped:
        state.selectedImageData = .empty
        state.isDisableDoneButton = true
        return .none
        
      case .backButtonDidTapped:
        return .run { _ in
          await dismiss()
        }
      case .delegate:
        return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
