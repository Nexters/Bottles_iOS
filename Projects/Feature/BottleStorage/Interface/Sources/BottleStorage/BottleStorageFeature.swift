//
//  BottleStorageFeature.swift
//  FeatureBottleStorage
//
//  Created by JongHoon on 7/25/24.
//

import CoreLoggerInterface
import DomainBottle
import FeatureReportInterface
import FeatureBottleArrivalInterface

import ComposableArchitecture

extension BottleStorageFeature {
  public init() {
    @Dependency(\.bottleClient) var bottleClient
    
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        state.isLoading = true
        return popToRootAndReload(state: &state)
        
      case let .bottleStorageListFetched(bottleStorageList):
        state.pingPongBottleList = bottleStorageList.pingPongBottles
        state.isLoading = false
        return .none
        
      case let .bottleStorageItemDidTapped(bottleID, isRead, userName):
        state.path.append(.pingPongDetail(.init(
          bottleID: bottleID,
          isRead: isRead,
          userName: userName
        )))
        return .none
        
      case .sandBeachButtonDidTapped:
        return .send(.delegate(.sandBeachButtonDidTapped))
        
      case let .path(.element(id: _, action: .pingPongDetail(.delegate(delegate)))):
        
        switch delegate {
        case .backButtonDidTapped:
          state.path.removeLast()
          return .none
        case .reportButtonDidTapped(let userReportProfile):
          state.path.append(.report(ReportUserFeature.State(userProfile: userReportProfile)))
          return .none
        case .otherBottleButtonDidTapped:
          return popToRootAndReload(state: &state)
        case .popToRootDidRequired:
          return popToRootAndReload(state: &state)
        }
        
      case let .path(.element(id: _, action: .report(.delegate(delegate)))):
        switch delegate {
        case .reportDidCompleted:
          state.path.removeAll()
          return .run { send in
            let bottleStorageList = try await bottleClient.fetchBottleStorageList()
            await send(.bottleStorageListFetched(bottleStorageList))
          }
        case .backButtonDidTapped:
          state.path.removeLast()
          return .none
        }
        
      case let .selectedTabDidChanged(selectedTab):
        return .send(.delegate(.selectedTabDidChanged(selectedTab: selectedTab)))
      default:
        return .none
      }
    }
    self.init(reducer: reducer)
    
    func popToRootAndReload(state: inout State) -> Effect<Action> {
      state.path.removeAll()
      return .run { send in
        let bottleStorageList = try await bottleClient.fetchBottleStorageList()
        await send(.bottleStorageListFetched(bottleStorageList))
      } catch: { error,send in
        // TODO: Error Handling
        Log.error(error)
      }
    }
  }
}

extension BottleStorageFeature {
  // MARK: - Path
  
  @Reducer(state: .equatable)
  public enum Path {
    case pingPongDetail(PingPongDetailFeature)
    case report(ReportUserFeature)
  }
}
