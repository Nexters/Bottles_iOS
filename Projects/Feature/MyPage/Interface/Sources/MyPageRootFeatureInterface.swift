//
//  MyPageRootFeatureInterface.swift
//  FeatureMyPageInterface
//
//  Created by 임현규 on 9/21/24.
//

import Foundation

import ComposableArchitecture

extension MyPageRootFeature {
  public init() {
    let reducer = Reduce<State, Action> { state, action in
      switch action {
        
      case .userProfileUpdateDidRequest:
        return .send(.myPage(.userProfileUpdateDidRequest))
      
      case let .selectedTabDidChanged(selectedTab):
        return .send(.delegate(.selectedTabDidChanged(selectedTab)))
        
      // MyPage Delegate
      case let .myPage(delegate):
        switch delegate {
        case .alertSettingListDidTapped:
          state.path.append(.AlertSetting(.init()))
          return .none
          
        case .accountSettingListDidTapped:
          state.path.append(.AccountSetting(.init()))
          return .none
          
        default:
          return .none
        }
        
      // AccountSetting Delegate
      case let .path(.element(id: _, action: .AccountSetting(.delegate(delegate)))):
        switch delegate {
        case .logoutDidCompleted:
          return .send(.delegate(.logoutDidCompleted))
          
        case .withdrawalButtonDidTapped:
          return .send(.delegate(.withdrawalButtonDidTapped))
          
        case .withdrawalDidCompleted:
          return .send(.delegate(.withdrawalDidCompleted))
        }
      
        
      default:
        return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
