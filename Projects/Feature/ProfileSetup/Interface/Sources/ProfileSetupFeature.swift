//
//  ProfileSetupFeature.swift
//  FeatureProfileSetupInterface
//
//  Created by 임현규 on 8/5/24.
//

import Foundation

import DomainProfileInterface
import SharedDesignSystem
import CoreLoggerInterface
import DomainProfile

import ComposableArchitecture

@Reducer
public struct ProfileSetupFeature {
  private var reducer: Reduce<State, Action>
  
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
    var introductionText: String = ""
    var selectedImage: Data = .empty
    public var introductionSetup: IntroductionSetupFeature.State = .init()
    public var imageUpload: ProfileImageUploadFeature.State = .init()
    
    public init() {}
  }
  
  public enum Action {
    case path(StackAction<Path.State, Path.Action>)
    case onAppear
    case introductionSetup(IntroductionSetupFeature.Action)
    case imageUpload(ProfileImageUploadFeature.Action)
    case introductionRegisterRequest
    case profileImageUploadRequest
    case requestsCompleted(TaskResult<Void>)
  }
  
  public var body: some ReducerOf<Self> {
    Scope(state: \.introductionSetup, action: \.introductionSetup) {
      IntroductionSetupFeature()
    }
    
    reducer
      .forEach(\.path, action: \.path)
  }
}

extension ProfileSetupFeature {
  public init() {
    let reducer = Reduce<State, Action> { state, action in
      
      @Dependency(\.profileClient) var profileClient
    
      switch action {
      case .onAppear:
        state.path.append(.IntroductionSetup(IntroductionSetupFeature.State()))
        return .none
        
      case .imageUpload:
        return .none
        
      case .introductionSetup:
        return .none
        
      case let .path(.element(id: _, action:
          .IntroductionSetup(.delegate(.nextButtonDidTapped(introductionText))))):
        state.introductionText = introductionText
        state.path.append(.ProfileImageUpload(ProfileImageUploadFeature.State()))
        return .none
        
      case let .path(.element(id: _, action:
          .ProfileImageUpload(.delegate(.doneButtonDidTapped(selectedImageData))))):
        state.selectedImage = selectedImageData

        return .run { [introduction = state.introductionText, imageData = state.selectedImage] send in
          
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

      case .path(_):
        return .none
        
      case .introductionRegisterRequest:
        return .run { [introduction = state.introductionText ] send in
          try await profileClient.registerIntroduction(answer: introduction)
        }
        
      case .profileImageUploadRequest:
        return .run { [imageData = state.selectedImage] send in
          try await profileClient.uploadProfileImage(imageData: imageData)
        }
        
      case .requestsCompleted(.success):
        Log.debug("자기소개 및 사진 업로드 성공")
        state.path.removeAll()
        return .none
        
      case .requestsCompleted(.failure):
        Log.error("자기소개 및 사진 업로드 실패")
        return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}

