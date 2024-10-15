//
//  GoodFeelingRootFeatureInterface.swift
//  FeatureGoodFeelingInterface
//
//  Created by JongHoon on 10/6/24.
//

import Foundation

import CoreToastInterface

import ComposableArchitecture

extension GoodFeelingRootFeature {
  public init() {
    @Dependency(\.toastClient) var toastClient
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case let .selectedTabDidChanged(selectedTab):
        return .send(.delegate(.selectedTabDidChanged(selectedTab)))
        
      // GoodFeeling Delegate
      case let .goodFeeling(.delegate(delegate)):
        switch delegate {
        case let .sentBottleTapped(url):
          state.path.append(.sentBottleDetail(.init(sentBottleDetailURL: url)))
          return .none
        }
        
      // GoodFeelingDetail Delegate
      case let .path(.element(id: _, action: .sentBottleDetail(.delegate(delegate)))):
        switch delegate {
        case .backButtonDidTapped:
          _ = state.path.popLast()
          return .none
          
        case .bottelDidAccepted:
          toastClient.presentToast(message: "이제 문답을 시작할 수 있어요.")
          state.path.popLast()
          return .send(.delegate(.selectedTabDidChanged(.bottleStorage)))
        }
        
      default:
        return .none
      }
    }
    
    self.init(reducer: reducer)
  }
}
