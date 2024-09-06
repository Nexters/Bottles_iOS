//
//  PhotoSharePingPongView.swift
//  DesignSystemExample
//
//  Created by 임현규 on 8/9/24.
//

import SwiftUI

import DomainBottleInterface

import SharedDesignSystem

public struct PhotoSharePingPongView: View {
  private let isActive: Bool
  private let pingPongTitle: String
  private let photoShareState: PingPongPhotoStatus
  private let myProfileImageURL: String?
  private let otherProfileImageURL: String?
  @Binding var isSelctedYesButton: Bool
  @Binding var isSelctedNoButton: Bool
  private let doneButtonAction: (() -> Void)?
  
  public init(
    isActive: Bool,
    pingPongTitle: String, 
    photoShareState: PingPongPhotoStatus,
    myProfileImageURL: String?,
    otherProfileImageURL: String?,
    isSelctedYesButton: Binding<Bool> = .constant(false),
    isSelctedNoButton: Binding<Bool> = .constant(false), 
    doneButtonAction: (() -> Void)? = nil
  ) {
    self.isActive = isActive
    self.pingPongTitle = pingPongTitle
    self.photoShareState = photoShareState
    self.myProfileImageURL = myProfileImageURL
    self.otherProfileImageURL = otherProfileImageURL
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
      
      switch photoShareState {
      case .requireSelect:
        notSelectedView
      case .waitingOtherAnswer:
        waitingForPeerView
      case .bothAgree:
        bothPublicView
      case .myReject:
        myRejectView
      case .otherReject:
        otherRejectView
      default:
        EmptyView()
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
  
  var myRejectView: some View {
    VStack(spacing: .sm) {
      makeRightBubbleText(text: "공유를 거절했어요")
      makeLeftBubbleText(text: "상대방에게 대화 중단을 알렸어요")
    }
  }
  
  var otherRejectView: some View {
    VStack(spacing: .sm) {
      makeLeftBubbleText(text: "공유를 거절했어요")
      makeLeftBubbleText(text: "상대방이 대화를 중단헀어요")
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
    if photoShareState == .requireSelect(otherSelected: false)
        || photoShareState == .requireSelect(otherSelected: true)
        || photoShareState == .waitingOtherAnswer
        || photoShareState == .myReject
        || photoShareState == .otherReject {
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
    if let peerProfileImageURL = otherProfileImageURL {
      GeometryReader { geo in
        RemoteImageView(
          imageURL: peerProfileImageURL,
          downsamplingWidth: 150,
          downsamplingHeight: 150
        )
        .frame(height: geo.size.width)
        .preventScreenshot()
      }
      .aspectRatio(1, contentMode: .fit)
      .clipped()
      .cornerRadius(.md, corenrs: [.topRight, .bottomLeft, .bottomRight])
    } else {
      EmptyView()
    }
  }
  
  @ViewBuilder
  var myProfileImage: some View {
    if let myProfileImageURL = myProfileImageURL {
      GeometryReader { geo in
        RemoteImageView(
          imageURL: myProfileImageURL,
          downsamplingWidth: 150,
          downsamplingHeight: 150
        )
        .frame(height: geo.size.width)
      }
      .aspectRatio(1, contentMode: .fit)
      .clipped()
      .cornerRadius(.md, corenrs: [.topRight, .topLeft, .bottomLeft])
    } else {
      EmptyView()
    }
  }
}
