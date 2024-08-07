//
//  SandBeachFeatureInterface.swift
//  FeatureSandBeach
//
//  Created by JongHoon on 7/25/24.
//

import Foundation

import SharedDesignSystem
import CoreLoggerInterface
import DomainProfile
import DomainBottle

import ComposableArchitecture

@Reducer
public struct SandBeachFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }

  @ObservableState
  public struct State: Equatable {
    public var userState: UserStateType = .none
    public var imageURL: String = "https://static.wikia.nocookie.net/wallaceandgromit/images/3/38/Gromit-3.png/revision/latest/scale-to-width/360?cb=20191228190308" // 임시
    public init() {}
  }
  
  public enum Action: Equatable {
    case onAppear
    case updateUserState(userState: UserStateType)
    case writeButtonDidTapped
    case newBottlePopupDidTapped
  }
  
  public var body: some ReducerOf<Self> {
    reducer
  }
}


// MARK: - init {
extension SandBeachFeature {
  public init() {
    @Dependency(\.profileClient) var profileClient
    @Dependency(\.bottleClient) var bottleClient
    
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .run { send in
          let isExsit = try await profileClient.checkExistIntroduction()
          // 자기소개 있는 경우
          if isExsit {
            await send(.updateUserState(userState: .noIntroduction))
            return
          }
          // 자기소개 없는 경우
          let bottlesCount = try await bottleClient.fetchNewBottlesCount()
          // 새로 도착한 보틀이 없는 경우
          guard let count = bottlesCount else {
            await send(.updateUserState(userState: .noBottle) )
            return
          }
          // 새로 도착한 보틀이 있는 경우
          await send(.updateUserState(userState: .hasBottle(bottleCount: count)))
        } catch: { error, send in
          // TODO: 에러 핸들링
          Log.error(error)
        }

        
      case let .updateUserState(userState):
        state.userState = userState
        Log.debug(state.userState)
        return .none
      default:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
// MARK: - Public Extension

public extension SandBeachFeature {
  enum UserStateType: Equatable {
    case noIntroduction              /// 자기소개 작성 X
    case noBottle                    /// 도착한 보틀 X
    case hasBottle(bottleCount: Int) /// 도착한 보틀 O
    case none                        /// 아무 상태도 아님
    
    var popUpText: String {
      switch self {
      case .noIntroduction: return "자기소개 작성 후 열어볼 수 있어요"
      case .noBottle:       return "n시간 후 새로운 보틀이 도착해요"
      case .hasBottle:      return "새로운 보틀이 도착했어요"
      default:              return ""
      }
    }
    
    var buttonText: String? {
      switch self {
      case .noIntroduction: return "자기소개 작성하기"
      default:              return nil
      }
    }
  }
}
