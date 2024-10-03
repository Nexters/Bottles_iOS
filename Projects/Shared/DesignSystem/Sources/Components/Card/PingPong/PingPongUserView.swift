//
//  PingPongUserView.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 9/28/24.
//

import SwiftUI

public struct PingPongUserView: View {
  private let status: String
  private let lastPingPongTime: String
  private let userName: String
  private let age: Int
  private let mbti: String
  private let imageURL: String
  private let isRead: Bool
  
  public init(
    status: String,
    lastPingPongTime: String,
    userName: String,
    age: Int,
    mbti: String,
    imageURL: String,
    isRead: Bool
  ) {
    self.status = status
    self.lastPingPongTime = lastPingPongTime
    self.userName = userName
    self.age = age
    self.mbti = mbti
    self.imageURL = imageURL
    self.isRead = isRead
  }
  
  public var body: some View {
    HStack(spacing: 0.0) {
      VStack(alignment: .leading, spacing: 0.0) {
        bottleStatus
        HStack(spacing: .xxs) {
          userNameText
          activeDot
        }
        .padding(.bottom, .sm)
        infos
      }
      Spacer()
      userImage
    }
    .padding(.md)
    .overlay(
      RoundedRectangle(cornerRadius: 20.0)
        .strokeBorder(
          ColorToken.border(.primary).color,
          lineWidth: 1.0
        )
    )
  }
}

// MARK: - Private Views

private extension PingPongUserView {
  var userNameText: some View {
    WantedSansStyleText(
      userName,
      style: .title2,
      color: .secondary
    )
  }
  
  @ViewBuilder
  var activeDot: some View {
    if isRead == false {
      ColorToken.icon(.update).color
        .frame(width: 4.0, height: 4.0)
        .clipShape(Circle())
    } else {
      EmptyView()
    }
  }
  
  var userImage: some View {
    BlurImageView(
      imageURL: imageURL,
      downsamplingWidth: 60.0,
      downsamplingHeight: 60.0
    )
    .frame(width: 48.0, height: 48.0)
    .clipShape(Circle())
  }
  
  var infos: some View {
    HStack(spacing: .xs) {
      WantedSansStyleText(
        "\(age)세",
        style: .caption,
        color: .secondary
      )
      
      verticalSeparator
      
      WantedSansStyleText(
        mbti,
        style: .caption,
        color: .secondary
      )
    }
  }
  
  var verticalSeparator: some View {
    ColorToken.border(.secondary).color
      .frame(width: 1.0, height: 12.0)
      .padding(1.0)
  }
  
  var bottleStatus: some View {
    HStack(spacing: .xs) {
      WantedSansStyleText(
        status,
        style: .caption,
        color: .secondary
      )
      verticalSeparator
      WantedSansStyleText(
        lastPingPongTime,
        style: .caption,
        color: .tertiary
      )
    }
    .padding(.xs)
    .background(to: ColorToken.onContainer(.secondary))
    .cornerRadius(.xs, corenrs: .allCorners)
    .padding(.bottom, .sm)
  }
}
