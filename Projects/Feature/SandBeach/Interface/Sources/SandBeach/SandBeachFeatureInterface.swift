//
//  SandBeachFeatureInterface.swift
//  FeatureSandBeach
//
//  Created by JongHoon on 7/25/24.
//

import Foundation

import SharedDesignSystem
import CoreLoggerInterface
import DomainProfile
import DomainBottle

import ComposableArchitecture

@Reducer
public struct SandBeachFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }

  @ObservableState
  public struct State: Equatable {
    public var userState: UserStateType = .none
    public var isLoading: Bool = false
    public var isDisableIslandBottle: Bool = false
    
    public init() {}
  }
  
  public enum Action: Equatable {
    case onAppear
    case userStateFetchCompleted(userState: UserStateType, isDisableButton: Bool)
    case updateIsDisableBottle(isDisable: Bool)
    case writeButtonDidTapped
    case newBottleIslandDidTapped
    case bottleStorageIslandDidTapped
    case delegate(Delegate)
    
    public enum Delegate {
      case writeButtonDidTapped
      case newBottleIslandDidTapped
      case bottleStorageIslandDidTapped
    }
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}

// MARK: - init {
extension SandBeachFeature {
  public init() {
    @Dependency(\.profileClient) var profileClient
    @Dependency(\.bottleClient) var bottleClient
    
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        state.isLoading = true

        return .run { send in
          let isExsit = try await profileClient.checkExistIntroduction()
          // 자기소개 없는 상태
          if isExsit {
            await send(.userStateFetchCompleted(
              userState: .noIntroduction,
              isDisableButton: true))
            return
          }
          let newBottlesCount = try await bottleClient.fetchNewBottlesCount()

          guard let count = newBottlesCount else {
            let bottlesStorageList = try await bottleClient.fetchBottleStorageList()
            let activeBottlesCount = bottlesStorageList.activeBottles.count
            
            // 자기소개만 작성한 상태
            if activeBottlesCount <= 0 {
              // TODO: time 설정
              await send(.userStateFetchCompleted(
                userState: .noBottle(time: 3),
                isDisableButton: true)
              )
            } else { // 대화 중인 보틀이 있는 상태
              await send(.userStateFetchCompleted(
                userState: .hasActiveBottle(bottleCount: activeBottlesCount),
                isDisableButton: false)
              )
            }
            return
          }
          // 새로 도착한 보틀이 있는 상태
          await send(.userStateFetchCompleted(
            userState: .hasNewBottle(bottleCount: count),
            isDisableButton: false)
          )
          
        } catch: { error, send in
          // TODO: 에러 핸들링
          Log.error(error)
        }
        
      case let .userStateFetchCompleted(userState, isDisableButton):
        state.userState = userState
        state.isDisableIslandBottle = isDisableButton
        state.isLoading = false
        return .none
                
      case .writeButtonDidTapped:
        return .send(.delegate(.writeButtonDidTapped))
        
      case .bottleStorageIslandDidTapped:
        Log.debug("bottleStorageIslandDidTapped")
        return .send(.delegate(.bottleStorageIslandDidTapped))
        }
        
      case .newBottleIslandDidTapped:
        Log.debug("newBottleIslandDidTapped")
        return .send(.delegate(.newBottleIslandDidTapped))
        }
        
      default:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
