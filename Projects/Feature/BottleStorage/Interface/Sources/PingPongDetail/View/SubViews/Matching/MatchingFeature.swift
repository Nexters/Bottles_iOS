//
//  MatchingFeature.swift
//  FeatureBottleStorage
//
//  Created by JongHoon on 8/11/24.
//

import Foundation

import CoreToastInterface
import CoreLoggerInterface

import ComposableArchitecture

extension MatchingFeature {
  public init() {
    @Dependency(\.toastClient) var toastClient
    
    let reducer = Reduce<State, Action> {
      state,
      action in
      switch action {
      case .onAppear:
        return .none
        
      case let .matchingStateDidFetched(matchResult, userName, matchingPlace, matchingPlaceImageURL):
        state.matchingPlace = matchingPlace
        state.matchingPlaceImageURL = matchingPlaceImageURL
        
        // 사용자 최종 선택 X
        state.peerUserName = userName
        
        // 매칭 성공
        if matchResult.matchStatus == .matchSucceeded {
          state.matchingState = .success
          state.kakaoTalkId = matchResult.otherContact
          return .none
        }
        
        // 매칭 실패
        if matchResult.matchStatus == .matchFailed {
          state.matchingState = .failure
          return .none
        }
        
        // 상대방 답변 X
        state.matchingState = .waiting
        
        return .none
      case .copyButtonDidTapped:
        toastClient.presentToast(message: "카카오톡 아이디를 복사했어요")
        return .none
        
      case .otherBottleButtonDidTapped:
        return .send(.delegate(.otherBottleButtonDidTapped))
        
      default:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
