//
//  SandBeachRootFeature.swift
//  FeatureSandBeachInterface
//
//  Created by 임현규 on 8/6/24.
//

import Foundation

import FeatureProfileSetupInterface
import FeatureBottleArrivalInterface
import FeatureTabBarInterface
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
    case BottleArrival(BottleArrivalFeature)
  }
  
  @ObservableState
  public struct State: Equatable {
    var path = StackState<Path.State>()
    var introduction: String
    var profileImageData: Data
    public var sandBeach: SandBeachFeature.State
    
    public init(
      path: StackState<Path.State> = StackState<Path.State>(),
      introduction: String = "",
      profileImageData: Data = .init(),
      sandBeach: SandBeachFeature.State = .init()
    ) {
      self.path = path
      self.introduction = introduction
      self.profileImageData = profileImageData
      self.sandBeach = sandBeach
    }
  }
  
  public enum Action {
    case path(StackAction<Path.State, Path.Action>)
    case sandBeach(SandBeachFeature.Action)
    case profileSetupDidCompleted
    case delegate(Delegate)
    case selectedTabDidChanged(selectedTab: TabType)
    
    public enum Delegate {
      case goToBottleStorageRequest
      case selectedTabDidChanged(selectedTab: TabType)
      case profileSetUpDidCompleted
    }
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
        
      // IntrodctionSetup Delegate
      case let .path(.element(id: _, action:
          .IntroductionSetup(.delegate(.nextButtonDidTapped(introductionText))))):
        state.introduction = introductionText
        state.path.append(.ProfileImageUpload(ProfileImageUploadFeature.State()))
        return .none
        
      // ProfileImageUpload Delegate
      case let .path(.element(id: _, action:
          .ProfileImageUpload(.delegate(.doneButtonDidTapped(selectedImageData))))):
        state.profileImageData = selectedImageData
        
        return .run { [introduction = state.introduction, imageData = state.profileImageData] send in
          // TODO: - 병렬처리 임시 중단 추후 처리
//          try await withThrowingTaskGroup(of: Void.self) { group in
//            group.addTask {
//              try await profileClient.registerIntroduction(answer: introduction)
//            }
//
//            group.addTask {
//              try await profileClient.uploadProfileImage(imageData: imageData)
//            }
//            for try await _ in group {}
          try await profileClient.registerIntroduction(answer: introduction)
          try await profileClient.uploadProfileImage(imageData: imageData)
          await send(.profileSetupDidCompleted)

        } catch: { error, send in
          // TODO: 자기소개 만들기 완료 실패 - 에러 핸들링
        }
        
      // BottleArrival Delegate
      case let .path(.element(id: _, action: .BottleArrival(.delegate(delegate)))):
        switch delegate {
        case .bottelDidAccepted:
          state.path.removeLast()
          return .send(.delegate(.goToBottleStorageRequest))
          
        case .closeWebView:
          state.path.removeLast()
          return .none
        }
        
      // SandBeach Delegate
      case let .sandBeach(.delegate(delegate)):
        switch delegate {
        case .bottleStorageIslandDidTapped:
          return .send(.delegate(.goToBottleStorageRequest))
          
        case .newBottleIslandDidTapped:
          state.path.append(.BottleArrival(BottleArrivalFeature.State()))
          return .none
          
        case .writeButtonDidTapped:
          state.path.append(.IntroductionSetup(IntroductionSetupFeature.State()))
          return .none
        }
        
      case .profileSetupDidCompleted:
        state.path.removeAll()
        return .send(.delegate(.profileSetUpDidCompleted))

      case let .selectedTabDidChanged(selectedTab):
        return .send(.delegate(.selectedTabDidChanged(selectedTab: selectedTab)))
      default:
        // TODO: 네트워크 에러 처리.
        return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
