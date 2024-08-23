//
//  QuestionAndAnswerFeature.swift
//  FeatureBottleStorage
//
//  Created by JongHoon on 8/11/24.
//

import Foundation

import CoreLoggerInterface

import ComposableArchitecture

extension QuestionAndAnswerFeature {
  public init() {
    @Dependency(\.bottleClient) var bottleClient
    
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
        
      case let .pingPongDidFetched(pingPong):
        state.configurePingPong(pingPong)
        return .none
        
      case let .texFieldDidFocused(isFocused):
        state.textFieldState = isFocused ? .focused : .active
        return .none
        
      case let .letterDoneButtonDidTapped(order, answer):
        state.isShowLoadingIndicator = true
        return .run { [bottleID = state.bottleID] send in
          try await bottleClient.registerLetterAnswer(
            bottleID: bottleID,
            order: order,
            answer: answer
          )
          await send(.refreshPingPongDidRequired)
        } catch: { error, send in
          Log.error(error)
        }
        
      case .refreshPingPongDidRequired:
        return .run { [bottleId = state.bottleID] send in
          let pingPong = try await bottleClient.fetchBottlePingPong(bottleID: bottleId)
          await send(.pingPongDidFetched(pingPong))
          await send(.configureShowLoadingIndicatorRequired(isShow: false))
        }
        
      case let .configureShowLoadingIndicatorRequired(isShow):
        state.isShowLoadingIndicator = isShow
        return .none
        
      case let .sharePhotoSelectButtonDidTapped(willShare):
        state.isShowLoadingIndicator = true
        return .run { [bottleID = state.bottleID] send in
          try await bottleClient.shareImage(
            bottleID: bottleID,
            willShare: willShare
          )
          switch willShare {
          case true:
            await send(.refreshPingPongDidRequired)
          case false:
            await send(.delegate(.popToRootDidRequired))
          }
        }
        
      case let .finalSelectButtonDidTapped(willMatch: willMatch):
        state.isShowLoadingIndicator = true
        return .run { [bottleID = state.bottleID] send in
          try await bottleClient.finalSelect(
            bottleID: bottleID,
            willMatch: willMatch
          )
          switch willMatch {
          case true:
            await send(.refreshPingPongDidRequired)
          case false:
            await send(.delegate(.popToRootDidRequired))
          }
        }
        
      case .stopTalkButtonDidTapped:
        state.destination = .alert(.init(
          title: { TextState("중단하기") },
          actions: {
            ButtonState(
              role: .destructive,
              action: .confirmStopTalk,
              label: { TextState("중단하기") })
          },
          message: { TextState("중단 시 모든 핑퐁 내용이 사라져요. 정말 중단하시겠어요?") }
        ))
        return .none

      case let .destination(.presented(.alert(alert))):
        switch alert {
        case .confirmStopTalk:
          state.isShowLoadingIndicator = true
          return .run { [bottleID = state.bottleID] send in
            try await bottleClient.stopTalk(bottleID: bottleID)
            await send(.delegate(.popToRootDidRequired))
          }
        }
        
      case .binding(\.firstLetterTextFieldContent):
        if state.firstLetterTextFieldContent.count >= 50 {
          state.textFieldState = .focused
        } else {
          state.textFieldState = .error
        }
        return .none
        
      case .binding(\.secondLetterTextFieldContent):
        if state.secondLetterTextFieldContent.count >= 50 {
          state.textFieldState = .focused
        } else {
          state.textFieldState = .error
        }
        return .none
        
      case .binding(\.thirdLetterTextFieldContent):
        if state.thirdLetterTextFieldContent.count >= 50 {
          state.textFieldState = .focused
        } else {
          state.textFieldState = .error
        }
        return .none
        
      case .binding, .destination, .alert:
        return .none
        
      default:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
