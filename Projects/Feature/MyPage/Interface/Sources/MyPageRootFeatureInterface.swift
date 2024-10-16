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
          state.path.append(.alertSetting(.init()))
          return .none
          
        case .accountSettingListDidTapped:
          state.path.append(.accountSetting(.init()))
          return .none
          
        case .profileEditListDidTapped:
          state.path.append(.editProfile(.init()))
          return .none
          
        case .accountSettingListDidTapped:
          state.path.append(.accountSetting(.init()))
          return .none
          
        case .profileEditListDidTapped:
          state.path.append(.editProfile(.init()))
          return .none
          
        default:
          return .none
        }
        
      // AccountSetting Delegate
      case let .path(.element(id: _, action: .accountSetting(.delegate(delegate)))):
        switch delegate {
        case .logoutDidCompleted:
          return .send(.delegate(.logoutDidCompleted))
          
        case .withdrawalButtonDidTapped:
          return .send(.delegate(.withdrawalButtonDidTapped))
          
        case .withdrawalDidCompleted:
          return .send(.delegate(.withdrawalDidCompleted))
        }
        
      case let .path(.element(id: _, action: .editProfile(.delegate(delegate)))):
        switch delegate {
        case .closeEditProfileView:
          _ = state.path.popLast()
          return .none
        }
        
      default:
        return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
