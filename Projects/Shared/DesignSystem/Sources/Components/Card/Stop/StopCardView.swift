//
//  StopCardView.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 8/7/24.
//

import SwiftUI

public struct StopCardView: View {
  private let userName: String
  
  public init(userName: String) {
    self.userName = userName
  }
  
  public var body: some View {
    VStack(spacing: .xl) {
      VStack(spacing: .xs) {
        titleText
        captionText
      }
      image
    }
    .padding(.horizontal, .md)
    .padding(.vertical, .xl)
    .overlay(roundedRectangle)
  }
}

// MARK: - Views
private extension StopCardView {
  var roundedRectangle: some View {
    RoundedRectangle(cornerRadius: BottleRadiusType.xl.value)
      .strokeBorder(
        ColorToken.border(.primary).color,
        lineWidth: 1
      )
  }
  
  var titleText: some View {
    HStack(spacing: 0) {
      WantedSansStyleText(
        "\(userName)님이 대화를 중단했어요",
        style: .subTitle1,
        color: .primary
      )
      Spacer()
    }
  }
  
  var captionText: some View {
    HStack(spacing: 0) {
      WantedSansStyleText(
        "대화는 3일 후 완전히 삭제돼요",
        style: .body,
        color: .tertiary
      )
      Spacer()
    }
  }
  
  // TODO: - 아직 디자인 안나옴 나오면 수정
  var image: some View {
    RemoteImageView(
      imageURL: "",
      downsamplingWidth: 120,
      downsamplingHeight: 120
    )
    .frame(width: 120)
    .frame(height: 120)
  }
}
