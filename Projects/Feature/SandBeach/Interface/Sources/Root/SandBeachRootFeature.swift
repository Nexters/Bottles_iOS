//
//  SandBeachRootFeature.swift
//  FeatureSandBeachInterface
//
//  Created by 임현규 on 8/6/24.
//

import Foundation

import FeatureProfileSetupInterface
import DomainProfile

import ComposableArchitecture

@Reducer
public struct SandBeachRootFeature {
  @Dependency(\.dismiss) var dismiss
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  
  @Reducer(state: .equatable)
  public enum Path {
    case IntroductionSetup(IntroductionSetupFeature)
    case ProfileImageUpload(ProfileImageUploadFeature)
  }
  
  @ObservableState
  public struct State: Equatable {
    var path = StackState<Path.State>()
    var introduction: String = ""
    var profileImageData: Data = .init()
    public var sandBeach: SandBeachFeature.State = .init()
    public var introductionSetup: IntroductionSetupFeature.State = .init()
    public var profileImageUpload: ProfileImageUploadFeature.State = .init()
    
    public init() {}
  }
  
  public enum Action {
    case path(StackAction<Path.State, Path.Action>)
    case sandBeach(SandBeachFeature.Action)
    case introductionSetup(IntroductionSetupFeature.Action)
    case profileImageUpload(ProfileImageUploadFeature.Action)
    case requestsCompleted(TaskResult<Void>)
  }
  
  public var body: some ReducerOf<Self> {
    Scope(state: \.sandBeach, action: \.sandBeach) {
      SandBeachFeature()
    }
    
    reducer
      .forEach(\.path, action: \.path)
  }
}

extension SandBeachRootFeature {
  public init() {

    let reducer = Reduce<State, Action> { state, action in
      @Dependency(\.profileClient) var profileClient
      
      switch action {
        
      case let .path(.element(id: _, action:
          .IntroductionSetup(.delegate(.nextButtonDidTapped(introductionText))))):
        state.introduction = introductionText
        state.path.append(.ProfileImageUpload(ProfileImageUploadFeature.State()))
        return .none
        
      case let .path(.element(id: _, action:
          .ProfileImageUpload(.delegate(.doneButtonDidTapped(selectedImageData))))):
        state.profileImageData = selectedImageData
        
        return .run { [introduction = state.introduction, imageData = state.profileImageData] send in
          await send(.requestsCompleted(TaskResult {
            try await withThrowingTaskGroup(of: Void.self) { group in
              group.addTask {
                try await profileClient.registerIntroduction(answer: introduction)
              }
              
              group.addTask {
                try await profileClient.uploadProfileImage(imageData: imageData)
              }
              for try await _ in group {}
            }
          }))
        }
        
      case .sandBeach(.newBottlePopupDidTapped):
        // TODO: 도착한 보틀 보관함으로 이동.
        return .none
        
      case .sandBeach(.writeButtonDidTapped):
        state.path.append(.IntroductionSetup(IntroductionSetupFeature.State()))
        return .none
        
      case .requestsCompleted(.success):
        state.path.removeAll()
        return .none
      
      case .requestsCompleted(.failure):
        // TODO: 네트워크 에러 처리.
        return .none
                
      default:
        return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
