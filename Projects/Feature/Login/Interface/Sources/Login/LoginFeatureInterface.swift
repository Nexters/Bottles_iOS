//
//  LoginFeatureInterface.swift
//  FeatureLogin
//
//  Created by JongHoon on 7/24/24.
//

import Foundation

import CoreLoggerInterface
import CoreNetwork
import DomainAuth
import DomainAuthInterface

import ComposableArchitecture
import KakaoSDKCommon

@Reducer
public struct LoginFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    var path = StackState<Path.State>()
    public init() {}
  }
  
  public enum Action: BindableAction {
    case onAppear
    case signInKakaoRequest
    case signInKakaoResponse(TaskResult<UserInfo>)
    case signUpCheckCompleted(isSignUp: Bool)
    case path(StackAction<Path.State, Path.Action>)
    case binding(BindingAction<State>)
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    reducer
      .forEach(\.path, action: \.path)
  }
}

extension LoginFeature {
  public init() {
    @Dependency(\.authClient) var authClient
    
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
      case .signInKakaoRequest:
        return .run { send in
          await send(.signInKakaoResponse(
            TaskResult {
              try await authClient.signInWithKakao().toDomain()
            }
          ))
        }
      case let .signInKakaoResponse(.success(userInfo)):
        let token = userInfo.token
        Log.debug(token)
        authClient.saveToken(token: token)
        let isSignUp = userInfo.isSignUp
        return .send(.signUpCheckCompleted(isSignUp: isSignUp))
      case let .signInKakaoResponse(.failure(error)):
        if let kakaoError = error as? SdkError {
          switch kakaoError {
          case .ClientFailed(let reason, _):
            switch reason {
            case .Cancelled:
              state.path.append(.generalLogin(.init()))
            default:
              return .none
            }
          default:
            return .none
          }
        }
        return .none
      case let .signUpCheckCompleted(isSignUp):
        if isSignUp {
          // TODO: TabView로 이동
          Log.debug(isSignUp)
          return .none
        } else {
          // TODO: OnboardingView로 이동
          Log.debug(isSignUp)
          return .none
        }
      case .path, .binding:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}

extension LoginFeature {
  // MARK: - Path
  
  @Reducer(state: .equatable)
  public enum Path {
    case generalLogin(GeneralLogInFeature)
  }
}
