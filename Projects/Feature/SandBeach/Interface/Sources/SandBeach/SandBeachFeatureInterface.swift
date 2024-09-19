//
//  SandBeachFeatureInterface.swift
//  FeatureSandBeach
//
//  Created by JongHoon on 7/25/24.
//

import Foundation
import UIKit

import DomainProfile
import DomainBottle
import DomainAuth
import DomainErrorInterface

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
    
    @Presents var destination: Destination.State?
    
    public init() {}
  }
  
  public enum Action: BindableAction {
    case onAppear
    case userStateFetchCompleted(userState: UserStateType, isDisableButton: Bool)
    case updateIsDisableBottle(isDisable: Bool)
    case writeButtonDidTapped
    case newBottleIslandDidTapped
    case bottleStorageIslandDidTapped
    case needUpdateAppVersionErrorOccured
    case updateAppVersion
    
    case delegate(Delegate)
    
    public enum Delegate {
      case writeButtonDidTapped
      case newBottleIslandDidTapped
      case bottleStorageIslandDidTapped
    }
    
    case alert(Alert)
    public enum Alert: Equatable {
      case needUpdateAppVersion
    }
    
    case destination(PresentationAction<Destination.Action>)
    case binding(BindingAction<State>)
  }
  
  public var body: some ReducerOf<Self> {
    reducer
      .ifLet(\.$destination, action: \.destination)
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
          async let _ = authClient.checkUpdateVersion()
          async let isExsit = try await profileClient.checkExistIntroduction()
          // 자기소개 없는 상태
            if try await !isExsit {
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
          if let authError = error as? DomainError.AuthError {
            switch authError {
            case .invalidAppVersion:
              await send(.needUpdateAppVersionErrorOccured)
            }
          }
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
        
      case .needUpdateAppVersionErrorOccured:
        state.destination = .alert(.init(
          title: { TextState("업데이트 안내") },
          actions: {
            ButtonState(
              action: .needUpdateAppVersion,
              label: { TextState("업데이트 하기") }
            )
          },
          message: { TextState("최적의 사용 환경을 위해\n최신 버전의 앱으로 업데이트 해주세요") }
        ))
        return .none
        
      case let .destination(.presented(.alert(alert))):
        switch alert {
        case .needUpdateAppVersion:
          return .send(.updateAppVersion)
        }
        
      case .updateAppVersion:
        let appStoreURL = URL(string: Bundle.main.infoDictionary?["APP_STORE_URL"] as? String ?? "")!
        UIApplication.shared.open(appStoreURL)
        return .run { send in
          await send(.needUpdateAppVersionErrorOccured)
        }
        
      default:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}

extension SandBeachFeature {
  @Reducer(state: .equatable)
  public enum Destination {
    case alert(AlertState<SandBeachFeature.Action.Alert>)
  }
}
