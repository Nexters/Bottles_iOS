//
//  BottleStorageList.swift
//  DesignSystemExample
//
//  Created by JongHoon on 8/8/24.
//

import SwiftUI

import SharedDesignSystem

struct BottleItem: Identifiable {
  let id: UUID
  let userName: String
  let age: Int
  let mbti: String
  let imageURL: String
  let keyworkds: [String]
  let isRead: Bool
  
  init(
    userName: String,
    age: Int,
    mbti: String,
    imageURL: String,
    keyworkds: [String],
    isRead: Bool
  ) {
    self.id = UUID()
    self.userName = userName
    self.age = age
    self.mbti = mbti
    self.imageURL = imageURL
    self.keyworkds = keyworkds
    self.isRead = isRead
  }
}

struct BottleStorageList: View {
  let bottles = [
    BottleItem(
      userName: "Test1",
      age: 20,
      mbti: "INTP",
      imageURL: "https://static.wikia.nocookie.net/wallaceandgromit/images/3/38/Gromit-3.png/revision/latest/scale-to-width/360?cb=20191228190308",
      keyworkds: ["성격1", "성격2", "성격3"],
      isRead: false
    ),
    BottleItem(
      userName: "Test1",
      age: 20,
      mbti: "INTP",
      imageURL: "https://static.wikia.nocookie.net/wallaceandgromit/images/3/38/Gromit-3.png/revision/latest/scale-to-width/360?cb=20191228190308",
      keyworkds: ["성격1", "성격2", "성격3"],
      isRead: true
    ),
    BottleItem(
      userName: "Test1",
      age: 20,
      mbti: "INTP",
      imageURL: "https://static.wikia.nocookie.net/wallaceandgromit/images/3/38/Gromit-3.png/revision/latest/scale-to-width/360?cb=20191228190308",
      keyworkds: ["성격1", "성격2", "성격3"],
      isRead: false
    ),
    BottleItem(
      userName: "Test1",
      age: 20,
      mbti: "INTP",
      imageURL: "https://static.wikia.nocookie.net/wallaceandgromit/images/3/38/Gromit-3.png/revision/latest/scale-to-width/360?cb=20191228190308",
      keyworkds: ["성격1", "성격2", "성격3"],
      isRead: true
    )
  ]
  
  var body: some View {
    VStack(spacing: 20.0) {
      ForEach(bottles, id: \.id) { bottle in
        PingPongUserView(
          status: "문답이 도착했어요",
          lastPingPongTime: "3시간 전",
          userName: bottle.userName,
          age: bottle.age, 
          mbti: bottle.mbti,
          imageURL: bottle.imageURL,
          isRead: bottle.isRead
        )
      }
    }
    .padding(20.0)
  }
}
