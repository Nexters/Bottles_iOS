//
//  SceneDelegateFeature.swift
//  Feature
//
//  Created by 임현규 on 8/20/24.
//

import Foundation
import AuthenticationServices

import CoreKeyChainStore
import CoreLoggerInterface

import ComposableArchitecture

@Reducer
public struct SceneDelegateFeature {
  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action {
    // Life cycle
    case didBecomeActive
    
    case logoutRequired
    
    // Delegate
    case delegate(Delegate)
    
    public enum Delegate {
      case logOutRequired
    }
  }
  
  public var body: some ReducerOf<Self> {
    Reduce(feature)
  }
  
  private func feature(
    state: inout State,
    action: Action
  ) -> EffectOf<Self> {
    switch action {
    case .didBecomeActive:
      
      let appleIDProvider = ASAuthorizationAppleIDProvider()
      let userID = KeyChainTokenStore.shared.load(property: .AppleUserID)
      
      if userID.isEmpty { return .none }
      
      return .run { send in
        let credentialState = try await appleIDProvider.credentialState(forUserID: userID)
        
        switch credentialState {
        case .authorized:
          Log.debug("애플 로그인 인증 성공")
        case .revoked:
          Log.error("애플 로그인 인증 만료")
          return await send(.delegate(.logOutRequired))
        case .notFound:
          Log.error("애플 Credential을 찾을 수 없음")
        default:
          break
        }
      } catch: { error, send in
        Log.error(error)
      }
      
    default:
      return .none
    }
  }
}
