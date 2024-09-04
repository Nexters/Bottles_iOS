//
//  PhotoSharePingPongView.swift
//  DesignSystemExample
//
//  Created by 임현규 on 8/9/24.
//

import SwiftUI

import SharedDesignSystem

public struct PhotoSharePingPongView: View {
  private let isActive: Bool
  private let pingPongTitle: String
  private let photoShareState: PhotoShareStateType
  @Binding var isSelctedYesButton: Bool
  @Binding var isSelctedNoButton: Bool
  private let doneButtonAction: (() -> Void)?
  
  public init(
    isActive: Bool,
    pingPongTitle: String, 
    photoShareState: PhotoShareStateType,
    isSelctedYesButton: Binding<Bool> = .constant(false), 
    isSelctedNoButton: Binding<Bool> = .constant(false), 
    doneButtonAction: (() -> Void)? = nil
  ) {
    self.isActive = isActive
    self.pingPongTitle = pingPongTitle
    self.photoShareState = photoShareState
    self._isSelctedYesButton = isSelctedYesButton
    self._isSelctedNoButton = isSelctedNoButton
    self.doneButtonAction = doneButtonAction
  }
  
  public var body: some View {
    PingPongContainer(
      isActive: isActive,
      pingpongTitle: pingPongTitle
    ) {
      content
    }
  }
}

// MARK: - Views
private extension PhotoSharePingPongView {
  var content: some View {
    VStack(spacing: .sm) {
      questionText
      
      if photoShareState == .notSelected {
        notSelectedView
      } else if photoShareState == .waitingForPeer {
        waitingForPeerView
      } else if photoShareState == .eitherPrivate {
        eitherPrivateView
      } else {
        bothPublicView
      }
    }
    .padding(.horizontal, .md)
    .padding(.vertical, .xl)
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
      makeRightBubbleText(text: "공유를 완료했어요")
      makeLeftBubbleText(text: "상대방의 답변을 기다리고 있어요")
      makeLeftBubbleText(text: "서로가 모두 공유에 동의한 경우에 공개돼요")
    }
  }
  
  var eitherPrivateView: some View {
    // TODO: 디자인 바뀌면 수정
    makeRightBubbleText(text: "사진 공개가 실패했어요")
  }
  
  var bothPublicView: some View {
    HStack(spacing: .sm) {
      peerProfileImage
      myProfileImage
    }
  }
  
  
  @ViewBuilder
  var questionText: some View {
    if photoShareState == .notSelected || photoShareState == .waitingForPeer {
      HStack(spacing: 0) {
        WantedSansStyleText(
          "나의 프로필 사진을 공유할까요?",
          style: .subTitle1,
          color: .focusePrimary
        )
        Spacer()
      }
      .padding(.bottom, .sm)
    } else {
      EmptyView()
    }
  }
  
  @ViewBuilder
  var peerProfileImage: some View {
    GeometryReader { geo in
      RemoteImageView(
        imageURL: photoShareState.peerProfileImageURL,
        downsamplingWidth: 150,
        downsamplingHeight: 150
      )
      .frame(height: geo.size.width)
      .preventScreenshot()
    }
    .aspectRatio(1, contentMode: .fit)
    .clipped()
    .cornerRadius(.md, corenrs: [.topRight, .bottomLeft, .bottomRight])
  }
  
  @ViewBuilder
  var myProfileImage: some View {
    if let myProfileImageURL = photoShareState.myProfileImageURL {
      GeometryReader { geo in
        RemoteImageView(
          imageURL: myProfileImageURL,
          downsamplingWidth: 150,
          downsamplingHeight: 150
        )
        .frame(height: geo.size.width)
        .preventScreenshot()
      }
      .aspectRatio(1, contentMode: .fit)
      .clipped()
      .cornerRadius(.md, corenrs: [.topRight, .topLeft, .bottomLeft])
    } else {
      EmptyView()
    }
  }
}
