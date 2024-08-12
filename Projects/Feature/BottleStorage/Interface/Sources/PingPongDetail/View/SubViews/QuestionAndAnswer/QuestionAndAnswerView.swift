//
//  QuestionAndAnswerView.swift
//  FeatureBottleStorage
//
//  Created by JongHoon on 8/11/24.
//

import SwiftUI

import SharedDesignSystem
import CoreLoggerInterface

import ComposableArchitecture

public struct QuestionAndAnswerView: View {
  @Perception.Bindable private var store: StoreOf<QuestionAndAnswerFeature>
  @FocusState private var isTextFieldFocused: Bool
          
  public init(store: StoreOf<QuestionAndAnswerFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      ScrollView {
        VStack(alignment: .leading, spacing: .sm) {
          // 질문
          QuestionPingPongView(
            pingpongTitle: "첫 번째 질문",
            textFieldContent: $store.firstLetterTextFieldContent,
            textFieldState: $store.textFieldState,
            isActive: store.isFirstLetterActive,
            questionContent: store.firstLetter?.question ?? "",
            questionState: store.firstLetterQuestionState,
            doneButtonAction: {
              store.send(.letterDoneButtonDidTapped(
                order: 1,
                answer: store.firstLetterTextFieldContent
              ))
            }
          )
          .focused($isTextFieldFocused)
          
          QuestionPingPongView(
            pingpongTitle: "두 번째 질문",
            textFieldContent: $store.secondLetterTextFieldContent,
            textFieldState: $store.textFieldState,
            isActive: store.isSecondLetterActive,
            questionContent: store.firstLetter?.question ?? "",
            questionState: store.secondLetterQuestionState,
            doneButtonAction: {
              store.send(.letterDoneButtonDidTapped(
                order: 2,
                answer: store.secondLetterTextFieldContent
              ))
            }
          )
          .focused($isTextFieldFocused)
          
          QuestionPingPongView(
            pingpongTitle: "세 번째 질문",
            textFieldContent: $store.thirdLetterTextFieldContent,
            textFieldState: $store.textFieldState,
            isActive: store.isThirdLetterActive,
            questionContent: store.firstLetter?.question ?? "",
            questionState: store.thirdLetterQuestionState,
            doneButtonAction: {
              store.send(.letterDoneButtonDidTapped(
                order: 3,
                answer: store.thirdLetterTextFieldContent
              ))
            }
          )
          .focused($isTextFieldFocused)
          
          PhotoSharePingPongView(
            isActive: store.photoShareIsActive,
            pingPongTitle: "사진 공개",
            photoShareState: store.photoShareStateType,
            isSelctedYesButton: $store.photoIsSelctedYesButton,
            isSelctedNoButton: $store.photoIsSelctedNoButton,
            doneButtonAction: {
              store.send(.sharePhotoSelectButtonDidTapped(willShare: store.photoIsSelctedYesButton))
            }
          )
          
          FinalSelectPingPongView(
            isActive: store.finalSelectIsActive,
            pingPongTitle: "최종 선택",
            finalSelectState: .notSelected,
            isSelctedYesButton: $store.finalSelectIsSelctedYesButton,
            isSelctedNoButton: $store.finalSelectIsSelctedNoButton,
            doneButtonAction: {
              store.send(.finalSelectButtonDidTapped(willMatch: store.finalSelectIsSelctedYesButton))
            }
          )
          
          HStack(spacing: 0.0) {
            Spacer()
            WantedSansStyleText(
              "대화 중단하기",
              style: .subTitle2,
              color: .enableSecondary
            )
            .asThrottleButton {
              store.send(.stopTaskButtonTapped)
            }
            .padding(.top, 12.0)
            .disabled(store.isStopped == true)
            Spacer()
          }
        }
        .padding(.md)
        .frame(maxWidth: .infinity)
        .onChange(of: isTextFieldFocused) { isFocused in
          store.send(.texFieldDidFocused(isFocused: isFocused))
        }
        .onChange(of: store.textFieldState) { textFieldState in
          isTextFieldFocused = textFieldState == .active || textFieldState == .enabled ? false : true
        }
      }
      .scrollIndicators(.hidden)
      .overlay {
        if store.isShowLoadingIndicator {
          LoadingIndicator()
        }
      }
      .alert($store.scope(state: \.destination?.alert, action: \.destination.alert))
    }
  }
}
