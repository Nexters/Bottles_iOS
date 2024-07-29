//
//  SandBeachFeature.swift
//  FeatureSandBeach
//
//  Created by JongHoon on 7/25/24.
//

import Foundation

import FeatureSandBeachInterface
import DomainProfile
import DomainBottle

import ComposableArchitecture

extension SandBeachFeature {
  public init() {
    @Dependency(\.profileClient) var profileClient
    @Dependency(\.bottleClient) var bottleClient
    
    // async let
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
      case .fetchNewBottleCountRequest:
        return .run { send in
          await send(.fetchNetBottleCountResponse(
            TaskResult {
              try await bottleClient.fetchNewBottlesCount()
            }
          ))
        }
      case .writeButtonDidTapped:
        // TODO: - 자기소개 작성 Feature로 이동.
        return .none
      case .fetchUserStateRequest:
        return .none
      case let .fetchUserStateResponse(.success(userState)):
        return userState == .noIntroduction ? .none : .send(.fetchNewBottleCountRequest)
      case let .fetchNetBottleCountResponse(.success(newBottleCount)):
        state.userState = newBottleCount > 0 ? .hasBottle : .noBottle
        return .none
      default:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
