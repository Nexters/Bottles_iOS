//
//  SandBeachFeature.swift
//  FeatureSandBeach
//
//  Created by JongHoon on 7/25/24.
//

import Foundation

import FeatureSandBeachInterface
import DomainProfile

import ComposableArchitecture

extension SandBeachFeature {
  public init() {
    @Dependency(\.profileClient) var profileClient
    
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .run { send in
          await send(.fetchUserStateResponse(
            TaskResult {
              try await profileClient.fetchUserState()
            }
          ))
        }
      case .writeButtonDidTapped:
        // TODO: - 자기소개 작성 Feature로 이동.
        return .none
      case .fetchUserStateRequest:
        return .none
      case let .fetchUserStateResponse(.success(userState)):
        state.userState = userState
        return .none
      default:
        state.userState = .hasBottle
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
