//
//  BottleStorageItem.swift
//  DesignSystemExample
//
//  Created by JongHoon on 8/8/24.
//

import SwiftUI

public struct BottleStorageItem: View {
  private let userName: String
  private let age: Int
  private let mbti: String
  private let imageURL: String
  private let keywords: [String]
  private let isRead: Bool
  
  public init(
    userName: String,
    age: Int,
    mbti: String,
    keywords: [String],
    imageURL: String,
    isRead: Bool
  ) {
    self.userName = userName
    self.age = age
    self.mbti = mbti
    self.keywords = keywords
    self.imageURL = imageURL
    self.isRead = isRead
  }
  
  public var body: some View {
    HStack(spacing: 0.0) {
      VStack(
        alignment: .leading,
        spacing: .xs
      ) {
        HStack(spacing: .xxs) {
          WantedSansStyleText(
            userName,
            style: .title2,
            color: .secondary
          )
          
          if isRead == false {
            ColorToken.icon(.update).color
              .frame(width: 4.0, height: 4.0)
              .clipShape(Circle())
          }
        }
        
        infos
      }
      
      Spacer()
      
      RemoteImageView(
        imageURL: imageURL,
        downsamplingWidth: 60.0,
        downsamplingHeight: 60.0
      )
      .frame(width: 48.0, height: 48.0)
      .clipShape(Circle())
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

private extension BottleStorageItem {
  var infos: some View {
    HStack(spacing: .xs) {
      WantedSansStyleText(
        "\(age)세",
        style: .caption,
        color: .tertiary
      )
      
      verticalSeparator
      
      WantedSansStyleText(
        mbti,
        style: .caption,
        color: .tertiary
      )
      
      verticalSeparator
      
      WantedSansStyleText(
         trimKeywords(keywords),
        style: .caption,
        color: .tertiary
      )
    }
  }
  
  var verticalSeparator: some View {
    ColorToken.border(.secondary).color
      .frame(width: 1.0, height: 12.0)
      .padding(1.0)
  }
}

// MARK: - Private Method

private extension BottleStorageItem {
  func trimKeywords(_ keywords: [String]) -> String {
    let keywords = keywords.prefix(3)
    return keywords.joined(separator: ", ")
  }
}
