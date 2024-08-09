//
//  UserProfileView.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 8/7/24.
//

import SwiftUI

public struct UserProfileView: View {
  private let imageURL: String
  private let userName: String
  private let userAge: Int
  
  public init(
    imageURL: String,
    userName: String,
    userAge: Int
  ) {
    self.imageURL = imageURL
    self.userName = userName
    self.userAge = userAge
  }
  
  public var body: some View {
    VStack(spacing: .sm) {
      profileImage
      HStack(spacing: .xs) {
        userNameText
        verticalLine
        userAgeText
      }
    }
  }
}

private extension UserProfileView {
  var profileImage: some View {
    RemoteImageView(
      imageURL: imageURL,
      downsamplingWidth: 80,
      downsamplingHeight: 80)
    .clipShape(Circle())
    .frame(width: 80, height: 80)
  }
  
  var userNameText: some View {
    WantedSansStyleText(
      userName,
      style: .subTitle1,
      color: .secondary)
  }
  
  var verticalLine: some View {
    LocalImageView(.icom(.verticalLine))
  }
  
  var userAgeText: some View {
    WantedSansStyleText(
      "\(userAge)세",
      style: .body,
      color: .secondary)
  }
}
