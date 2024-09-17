//
//  SplashFeature.swift
//  Feature
//
//  Created by JongHoon on 9/11/24.
//

import Foundation
import UIKit

import CoreLoggerInterface

import DomainAuthInterface
import DomainErrorInterface

import ComposableArchitecture

@Reducer
public struct SplashFeature {
  @Dependency(\.authClient) private var authClient
  
  @ObservableState
  public struct State: Equatable {
    @Presents var destination: Destination.State?
  }
  
  public enum Action: BindableAction {
    case onAppear
    case needUpdateAppVersionErrorOccured
    
    case updateAppVersion
    
    case delegate(Delegate)
    public enum Delegate {
      case initialCheckCompleted
    }
    
    case alert(Alert)
    public enum Alert: Equatable {
      case needUpdateAppVersion
    }
    
    case destination(PresentationAction<Destination.Action>)
    case binding(BindingAction<State>)
  }
  
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Reduce(feature)
      .ifLet(\.$destination, action: \.destination)
  }
  
  private func feature(
    state: inout State,
    action: Action
  ) -> EffectOf<Self> {
    switch action {
    case .onAppear:
      return .run { send in
        try await authClient.checkUpdateVersion()
        await send(.delegate(.initialCheckCompleted))
      } catch: { error, send in
        Log.error(error)
        // TODO: Error handling
        if let authError = error as? DomainError.AuthError {
          switch authError {
          case .needUpdateAppVersion:
            await send(.needUpdateAppVersionErrorOccured)
          }
        }
      }
      
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
      
    case .alert, .delegate, .destination, .binding:
      return .none
    }
  }
}

extension SplashFeature {
  @Reducer(state: .equatable)
  public enum Destination {
    case alert(AlertState<SplashFeature.Action.Alert>)
  }
}
