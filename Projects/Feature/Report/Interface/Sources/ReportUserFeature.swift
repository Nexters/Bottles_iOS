//
//  ReportUserFeature.swift
//  FeatureReportInterface
//
//  Created by 임현규 on 8/12/24.
//

import Foundation

import SharedDesignSystem
import ComposableArchitecture

extension ReportUserFeature {
  public init() {
    let reducer = Reduce<State, Action> { state, action in
      switch action {
      case .onAppear:
        return .none
      case let .texFieldDidFocused(isFocused):
        state.textFieldState = isFocused ? .focused : .active
        return .none
        
      case .doneButtonDidTapped:
        print("tapped")
        state.destination = .alert(.init(
          title: { TextState("신고하기")},
          actions: { ButtonState(
            role: .destructive,
            action: .confirmReport,
            label: { TextState("신고하기") }) },
          message: { TextState("접수 후 취소할 수 없으며 해당 사용자는 차단되요.\n정말 신고하시겠어요?")}))
        return .none
        
      case .onTapGesture:
        if state.reportText.isEmpty {
          state.textFieldState = .enabled
        } else {
          state.textFieldState = .active
        }
        return .none
        
      case .destination(.presented(.alert(.confirmReport))):
        return .run { send in
          // TODO: - 신고하기 구현
          await send(.delegate(.reportDidCompleted))
        }
        
      case .binding(\.reportText):
        state.isDisableDoneButton = state.isDisableDoneButton.description.isEmpty
        return .none
      default:
        return .none
      }
    }
    self.init(reducer: reducer)
  }
}
