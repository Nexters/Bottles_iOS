//
//  AppDelegateFeature.swift
//  Feature
//
//  Created by JongHoon on 7/23/24.
//

import Foundation

import DomainUserInterface

import ComposableArchitecture

import KakaoSDKCommon

@Reducer
public struct AppDelegateFeature {
  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action {
    case didFinishLunching
    case didReceivedFcmToken(fcmToken: String)
    case pushNotificationAllowStatusDidChanged(isAllow: Bool)
    
    // Delegate
    case delegate(Delegate)
    
    public enum Delegate {
      case fcmTokenDidRecevied(fcmToken: String)
    }
  }
  
  public var body: some ReducerOf<Self> {
    Reduce(feature)
  }
  
  private func feature(
    state: inout State,
    action: Action
  ) -> EffectOf<Self> {
    @Dependency(\.userClient) var userClient
    
    switch action {
    case .didFinishLunching:
      guard let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_APP_KEY"] as? String else { 
        fatalError("XCConfig Setting Error")
      }
      
      KakaoSDK.initSDK(appKey: kakaoAppKey)
      return .none
      
    case let .didReceivedFcmToken(fcmToken):
      return .run { send in
        await send(.delegate(.fcmTokenDidRecevied(fcmToken: fcmToken)))
      }
      
    case let .pushNotificationAllowStatusDidChanged(isAllow):
      userClient.updatePushNotificationAllowStatus(isAllow: isAllow)
      return .none
      
    default:
      return .none
    }
  }
}
