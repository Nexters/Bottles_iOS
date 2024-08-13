//
//  FinalSelectPingPongView.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 8/9/24.
//

import SwiftUI
import SharedDesignSystem

public struct FinalSelectPingPongView: View {
  private let isActive: Bool
  private let pingPongTitle: String
  private let finalSelectState: FinalSelectStateType
  @Binding var isSelctedYesButton: Bool
  @Binding var isSelctedNoButton: Bool
  private let doneButtonAction: (() -> Void)?
  
  public init(
    isActive: Bool,
    pingPongTitle: String,
    finalSelectState: FinalSelectStateType,
    isSelctedYesButton: Binding<Bool> = .constant(false),
    isSelctedNoButton: Binding<Bool> = .constant(false),
    doneButtonAction: (() -> Void)? = nil
  ) {
    self.isActive = isActive
    self.pingPongTitle = pingPongTitle
    self.finalSelectState = finalSelectState
    self._isSelctedYesButton = isSelctedYesButton
    self._isSelctedNoButton = isSelctedNoButton
    self.doneButtonAction = doneButtonAction
  }
  
  public var body: some View {
    PingPongContainer(
      isActive: isActive,
      pingpongTitle: pingPongTitle) {
        content
      }
  }
}

// MARK: - Views
private extension FinalSelectPingPongView {
  var content: some View {
    VStack(spacing: .sm) {
      questionText
      if finalSelectState == .notSelected {
        notSelectedView
      } else if finalSelectState == .waitingForPeer {
        waitingForPeerView
      } else {
        bothSelectedView
      }
    }
    .padding(.horizontal, .md)
    .padding(.vertical, .xl)
  }
  
  var questionText: some View {
    HStack(spacing: 0) {
      WantedSansStyleText(
        "나의 카카오톡 아이디를 공유할까요?",
        style: .subTitle1,
        color: .focusePrimary
      )
      Spacer()
    }
    .padding(.bottom, .sm)
  }
  
  var notSelectedView: some View {
    VStack(spacing: .sm) {
      HStack(spacing: .sm) {
        OutlinedStyleButton(
          .medium(contentType: .image(type: .local(bottleImageSystem: .illustraition(.yes)))),
          title: "네! 좋아요",
          buttonType: .normal,
          isSelected: isSelctedYesButton,
          action: {
            isSelctedYesButton.toggle()
            isSelctedNoButton = !isSelctedYesButton
            print("좋아요 클릭")
          }
        )
        
        OutlinedStyleButton(
          .medium(contentType: .image(type: .local(bottleImageSystem: .illustraition(.no)))),
          title: "아니요",
          buttonType: .normal,
          isSelected: isSelctedNoButton,
          action: {
            isSelctedNoButton.toggle()
            isSelctedYesButton = !isSelctedNoButton
            print("아니요 클릭")
          }
        )
      }
      
      SolidButton(
        title: "선택 완료",
        sizeType: .medium,
        buttonType: .throttle,
        action: doneButtonAction ?? {})
    }
  }
  
  var waitingForPeerView: some View {
    VStack(spacing: .sm) {
      makeRightBubbleText(text: "선택을 완료했어요")
      makeLeftBubbleText(text: "상대방의 선택을 기다리고 있어요")
      makeLeftBubbleText(text: "두근두근, 매칭이 이뤄질까요?")
    }
  }
  
  var bothSelectedView: some View {
    VStack(spacing: .sm) {
      makeRightBubbleText(text: "선택을 완료했어요")
      makeLeftBubbleText(text: "선택을 완료했어요")
      makeLeftBubbleText(text: "매칭 탭에서 결과를 확인해주세요")
    }
  }
}
