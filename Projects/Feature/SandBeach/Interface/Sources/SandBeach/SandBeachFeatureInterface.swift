//
//  SandBeachFeatureInterface.swift
//  FeatureSandBeach
//
//  Created by JongHoon on 7/25/24.
//

import Foundation

import DomainProfileInterface
import ComposableArchitecture

@Reducer
public struct SandBeachFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    public var userState: UserStateType = .noIntroduction
    public var imageURL: String = "https://static.wikia.nocookie.net/wallaceandgromit/images/3/38/Gromit-3.png/revision/latest/scale-to-width/360?cb=20191228190308" // 임시
    public init() {}
  }
  
  public enum Action: Equatable {
    case onAppear
    case writeButtonDidTapped
    case fetchUserStateRequest
    case fetchUserStateResponse(TaskResult<UserStateType>)
    case fetchNewBottleCountRequest
    case fetchNetBottleCountResponse(TaskResult<Int>)
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}

extension UserStateType {
  var popUpText: String {
    switch self {
    case .noIntroduction: return "자기소개 작성 후 열어볼 수 있어요"
    case .noBottle:       return "n시간 후 새로운 보틀이 도착해요"
    case .hasBottle:      return "새로운 보틀이 도착했어요"
    }
  }
  
  var buttonText: String? {
    switch self {
    case .noIntroduction: return "자기소개 작성하기"
    default:              return nil
    }
  }
}
