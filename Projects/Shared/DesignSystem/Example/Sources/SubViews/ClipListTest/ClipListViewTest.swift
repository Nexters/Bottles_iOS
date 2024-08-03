//
//  ClipListViewTest.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 8/2/24.
//

import SwiftUI

import SharedDesignSystem

public struct ClipListViewTest: View {
  public init() {}
  public var body: some View {
    ClipListView(
      clipItem: ClipItem(
        title: "내가 푹 빠진 취미는",
        list: ["코인노래방", "헬스", "드라이브", "만화 웹툰 정주행", "자전거"]
      )
    )
    .padding(.sm)
  }
}
