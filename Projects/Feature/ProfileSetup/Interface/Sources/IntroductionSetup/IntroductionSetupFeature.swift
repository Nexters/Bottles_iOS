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
    public var introductionText: String
    public var textFieldState: TextFieldState
    public var keywordItem: [ClipItem]
    public var isNextButtonDisable: Bool
    public var maxLength: Int
    public var isLoading: Bool
    
    public init(
      introductionText: String = "",
      textFieldState: TextFieldState = .enabled,
      keywordItem: [ClipItem] = [],
      isNextButtonDisable: Bool = true,
      maxLength: Int = 50,
      isLoading: Bool = false
    ) {
      self.introductionText = introductionText
      self.textFieldState = textFieldState
      self.keywordItem = keywordItem
      self.isNextButtonDisable = isNextButtonDisable
      self.maxLength = maxLength
      self.isLoading = isLoading
    }
  }
  
  public enum Action: BindableAction {
    // View Life Cycle
    case onLoad
    
    // User Action
    case texFieldDidFocused(isFocused: Bool)
    case profileSelectDidFatched(ProfileSelect)
    case nextButtonDidTapped
    case onTapGesture
    case backButtonDidTapped
    
    // Delegate
    case delegate(Delegate)
    case binding(BindingAction<State>)
    
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
    @Dependency(\.dismiss) var dismiss
    let reducer = Reduce<State, Action> { state, action in
      @Dependency(\.profileClient) var profileClient
      
      switch action {
      case .onLoad:
        state.isLoading = true
        return .run { send in
          let profileSelect = try await profileClient.fetchProfileSelect()
          await send(.profileSelectDidFatched(profileSelect))
        }
      case let .texFieldDidFocused(isFocused):
        state.textFieldState = isFocused ? .focused : .active
        return .none
      case .profileSelectDidFatched(let profileSelect):
        // TODO: 코드 개선
        // TODO: 없으면 ClipItem nil로
        state.keywordItem = [
          ClipItem(
            title: "내 키워드를 참고해보세요",
            list: [profileSelect.job, profileSelect.mbti, "\(profileSelect.region.city) \(profileSelect.region.state)", "\(profileSelect.height)", profileSelect.smoke, profileSelect.alcohol]
          ),
          
          ClipItem(
            title: "나의 성격은",
            list: profileSelect.keyword
          ),
          
          ClipItem(
            title: "내가 푹 빠진 취미는",
            list: (profileSelect.interset.culture ?? [])
            + (profileSelect.interset.entertainment ?? [])
            + (profileSelect.interset.sports ?? [])
            + (profileSelect.interset.etc ?? [])
          )
        ]
        state.isLoading = false
        return .none
      case .binding(\.introductionText):
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
        if state.introductionText.count == 0 {
          state.textFieldState = .enabled
        } else {
          state.textFieldState = .active
        }
        return .none
        
      case .backButtonDidTapped:
        return .run { _ in
            await dismiss()
        }
        
      case .binding(_):
        return .none

      case .delegate:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
