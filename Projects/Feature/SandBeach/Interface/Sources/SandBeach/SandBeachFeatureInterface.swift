//
//  SandBeachFeatureInterface.swift
//  FeatureSandBeach
//
//  Created by JongHoon on 7/25/24.
//

import Foundation

import DomainProfile
import DomainBottle
import DomainAuth

import CoreLoggerInterface

import SharedDesignSystem
import SharedUtilInterface

import ComposableArchitecture
import FirebaseMessaging

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
    @Dependency(\.authClient) var authClient
    @Dependency(\.profileClient) var profileClient
    @Dependency(\.bottleClient) var bottleClient
    
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        state.isLoading = true
        let authOptions: UNAuthorizationOptions = [
            .alert,
            .badge,
            .sound
        ]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, error in
                if let error = error {
                    Log.error(error)
                }
        })

        return .run { send in
//          let test = try await authClient.fetchUpdateVersion()
//          Log.debug(test)
          
          let isExsit = try await profileClient.checkExistIntroduction()
          // 자기소개 없는 상태
          if !isExsit {
            await send(.userStateFetchCompleted(
              userState: .noIntroduction,
              isDisableButton: true))
            return
          }
          
          let userBottleInfo = try await bottleClient.fetchUserBottleInfo()
          let newBottlesCount = userBottleInfo.randomBottleCount + userBottleInfo.sendBottleCount
          // 새로 도착한 보틀이 있는 상태
          
          if newBottlesCount > 0 {
            await send(.userStateFetchCompleted(
              userState: .hasNewBottle(bottleCount: newBottlesCount),
              isDisableButton: false)
            )
          } else {
            let bottlesStorageList = try await bottleClient.fetchBottleStorageList()
            let activeBottlesCount = bottlesStorageList.activeBottles.count
            
            // 자기소개만 작성한 상태
            if activeBottlesCount <= 0 {
              // TODO: time 설정
              let nextBottleLeftHours = userBottleInfo.nextBottlLeftHours
              await send(.userStateFetchCompleted(
                userState: .noBottle(time: nextBottleLeftHours ?? 0),
                isDisableButton: true)
              )
            } else { // 대화 중인 보틀이 있는 상태
              await send(.userStateFetchCompleted(
                userState: .hasActiveBottle(bottleCount: activeBottlesCount),
                isDisableButton: false)
              )
            }
          }
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
        
      case .newBottleIslandDidTapped:
        Log.debug("newBottleIslandDidTapped")
        return .send(.delegate(.newBottleIslandDidTapped))
        
      default:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
