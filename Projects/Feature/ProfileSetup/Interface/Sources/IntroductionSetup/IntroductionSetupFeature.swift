//
//  IntroductionSetupFeature.swift
//  FeatureProfileSetupInterface
//
//  Created by 임현규 on 8/5/24.
//

import Foundation

import DomainProfileInterface
import DomainProfile
import SharedDesignSystem
import CoreLoggerInterface

import ComposableArchitecture

@Reducer
public struct IntroductionSetupFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    public var introductionText: String = ""
    public var textFieldState: TextFieldState = .enabled
    public var keywordItem: [ClipItem] = []
    public var isNextButtonDisable: Bool = true
    public let maxLength: Int = 50
    public init() {}
  }
  
  public enum Action: BindableAction {
    case onLoad
    case texFieldDidFocused(isFocused: Bool)
    case binding(BindingAction<State>)
    case setKeyworkItem(UserProfile)
    case nextButtonDidTapped
    case onTapGesture
    case delegate(Delegate)
    
    public enum Delegate {
      case nextButtonDidTapped(introductionText: String)
    }
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    reducer
  }
}

extension IntroductionSetupFeature {
  public init() {
    let reducer = Reduce<State, Action> { state, action in
      @Dependency(\.profileClient) var profileClient
      
      switch action {
      case .onLoad:
        return .run { send in
          let userProfile = try await profileClient.fetchUserProfile()
          await send(.setKeyworkItem(userProfile))
        }
      case let .texFieldDidFocused(isFocused):
        state.textFieldState = isFocused ? .focused : .active
        return .none
      case .setKeyworkItem(let userProfile):
        Log.debug(userProfile)
        
        // TODO: 코드 개선
        state.keywordItem = [
          ClipItem(
            title: "내 키워드를 참고해보세요",
            list: [userProfile.job, userProfile.mbti, "\(userProfile.region.city) \(userProfile.region.state)", "\(userProfile.height)", userProfile.smoke, userProfile.alcohol]
          ),
          
          ClipItem(
            title: "나의 성격은",
            list: userProfile.keyword
          ),
          
          ClipItem(
            title: "내가 푹 빠진 취미는",
            list: (userProfile.interset.culture ?? [])
            + (userProfile.interset.entertainment ?? [])
            + (userProfile.interset.etc ?? [])
            + (userProfile.interset.etc ?? [])
          )
        ]
        return .none
      case .binding(\.introductionText):
        // TODO: - 텍스트 붙여넣기로 300자 이상 텍스트 붙여넣었을 때 때 prefix처리.
        // TODO: - 300자 이상 입력못하게 막기. -> Feature에서 처리? View에서 처리?

        if state.introductionText.count >= state.maxLength {
          state.textFieldState = .focused
          state.isNextButtonDisable = false
        } else {
          state.textFieldState = .error
          state.isNextButtonDisable = true
        }
        return .none
        
      case .nextButtonDidTapped:
        return .run { [introductionText = state.introductionText] send in
          Log.debug("nextButtonDidTapped")
          await send(.delegate(.nextButtonDidTapped(introductionText: introductionText)))
        }
        
      case .onTapGesture:
        state.textFieldState = .active
        return .none
      case .binding(_):
        return .none
      case .delegate:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
