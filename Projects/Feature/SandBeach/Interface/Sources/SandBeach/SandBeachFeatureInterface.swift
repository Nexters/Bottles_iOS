//
//  SandBeachFeatureInterface.swift
//  FeatureSandBeach
//
//  Created by JongHoon on 7/25/24.
//

import Foundation

import DomainSandBeachInterface

import ComposableArchitecture

@Reducer
public struct SandBeachFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    var userState: UserStateType = .noIntroduction
    var imageURL: String = "https://static.wikia.nocookie.net/wallaceandgromit/images/3/38/Gromit-3.png/revision/latest/scale-to-width/360?cb=20191228190308" // 임시
    public init() {}
  }
  
  public enum Action {
    case onAppear
    case writeButtonDidTapped
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}
