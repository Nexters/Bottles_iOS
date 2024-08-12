//
//  QuestionPingPongView.swift
//  FeatureBottleStorageInterface
//
//  Created by 임현규 on 8/9/24.
//

import SwiftUI
import SharedDesignSystem

public struct QuestionPingPongView: View {
  
  @Binding private var textFieldContent: String
  @Binding private var textFieldState: TextFieldState
  private var pingpongTitle: String
  private let isActive: Bool
  private let questionContent: String
  private let questionState: QuestionStateType
  private let doneButtonAction: (() -> Void)?
  
  public init(
    pingpongTitle: String,
    textFieldContent: Binding<String> = Binding.constant(""),
    textFieldState: Binding<TextFieldState> = Binding.constant(.enabled),
    isActive: Bool,
    questionContent: String = "",
    questionState: QuestionStateType = .none,
    doneButtonAction: (() -> Void)? = nil
  ) {
    self.pingpongTitle = pingpongTitle
    self._textFieldContent = textFieldContent
    self._textFieldState = textFieldState
    self.isActive = isActive
    self.questionContent = questionContent
    self.questionState = questionState
    self.doneButtonAction = doneButtonAction
  }
  
  public var body: some View {
    PingPongContainer(
      isActive: isActive,
      pingpongTitle: pingpongTitle) {
        content
      }
  }
}

private extension QuestionPingPongView {
  var content: some View {
    VStack(spacing: .sm) {
      questionText
      
      if questionState.peerAnswer != nil {
        if questionState.myAnswer != nil {
          // 상대방 O, 본인 O
          peerAnswerText
          myAnswerText
        } else {
          // 상대방 O, 본인 X
          peerAnswerArrivedText
          checkText
          textField
        }
      } else {
        if questionState.myAnswer != nil {
          // 상대방 X, 본인 O
          myAnswerText
          peerWaitingText
        } else {
          // 상대방 X, 본인 X
          peerWaitingText
          textField
        }
      }
    }
    .onTapEndEditing()
    .padding(.horizontal, .md)
    .padding(.vertical, .xl)
    .transition(.move(edge: .top))
    .zIndex(1)
  }

  
  @ViewBuilder
  var textField: some View {
      LinesTextField(
        textFieldType: .letter,
        textFieldState: $textFieldState,
        text: $textFieldContent,
        placeHolder: "솔직하게 작성할수록 서로를 알아가는데 도움이 돼요",
        buttonTitle: "작성 완료",
        textLimit: 150,
        action: doneButtonAction
      )
  }
  
  var questionText: some View {
    HStack(spacing: 0) {
      WantedSansStyleText(
        questionContent,
        style: .subTitle1,
        color: .focusePrimary
      )
      Spacer()
    }
    .padding(.bottom, .sm)
  }
  
  @ViewBuilder
  var myAnswerText: some View {
    if let myAnswer = questionState.myAnswer {
      makeRightBubbleText(text: myAnswer)
    } else {
      EmptyView()
    }
  }
  
  @ViewBuilder
  var peerAnswerText: some View {
    if let peerAnswer = questionState.peerAnswer {
      makeLeftBubbleText(text: peerAnswer)
    } else {
      EmptyView()
    }
  }
  
  var peerWaitingText: some View {
    makeLeftBubbleText(text: "상대방의 답변을 기다리고 있어요")
  }
  
  var peerAnswerArrivedText: some View {
    makeLeftBubbleText(text: "상대방의 답변이 도착했어요")
  }
  
  var checkText: some View {
    makeLeftBubbleText(text: "답변을 작성하면 확인할 수 있어요!")
  }
}
