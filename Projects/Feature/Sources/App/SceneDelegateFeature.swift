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
    case didBecomeActive
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
      
      appleIDProvider.getCredentialState(forUserID: userID) { credentialState, error in
        switch credentialState {
        case .authorized:
          Log.debug("애플 로그인 인증 성공")
        case .revoked:
          Log.error("애플 로그인 인증 만료")
        case .notFound:
          Log.error("애플 Credential을 찾을 수 없음")
        default:
          break
        }
      }
      return .none
    }
  }
}
