//
//  BottleStorageFeature.swift
//  FeatureBottleStorage
//
//  Created by JongHoon on 7/25/24.
//

import CoreLoggerInterface
import DomainBottle
import FeatureReportInterface

import ComposableArchitecture

extension BottleStorageFeature {
  public init() {
    @Dependency(\.bottleClient) var bottleClient
    
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .run { send in
          let bottleStorageList = try await bottleClient.fetchBottleStorageList()
          await send(.bottleStorageListFetched(bottleStorageList))
        } catch: { error,send in
          // TODO: Error Handling
          Log.error(error)
        }
        
      case let .bottleStorageListFetched(bottleStorageList):
        state.activeBottleList = bottleStorageList.activeBottles
        state.doneBottlsList = bottleStorageList.doneBottles
        return .none
        
      case let .bottleStorageItemDidTapped(bottleID, userName):
        state.path.append(.pingPongDetail(.init(bottleID: bottleID, userName: userName)))
        return .none
        
      case let .bottleActiveStateTabButtonTapped(activeState):
        state.selectedActiveStateTab = activeState
        return .none
        
      case let .path(.element(id: _, action: .pingPongDetail(.delegate(delegate)))):
        
        switch delegate {
        case .backButtonDidTapped:
          state.path.removeLast()
          return .none
        case .reportButtonDidTapped:
          return .none
        }
        
      case .binding, .path:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}

extension BottleStorageFeature {
  // MARK: - Path
  
  @Reducer(state: .equatable)
  public enum Path {
    case pingPongDetail(PingPongDetailFeature)
  }
}
