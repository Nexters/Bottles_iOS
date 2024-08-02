//
//  ClipListContainerViewTest.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 8/2/24.
//

import SwiftUI

public struct ClipListContainerViewTest: View {
  public init() {}
  public var body: some View {
    ClipListContainerView(
      clipItemList: [
        ClipItem(
          title: "내 키워드를 참고해보세요",
          list: ["직장인", "MBTI", "city_name", "height", "흡연 안해요", "술을 즐겨요"]
        ),
        ClipItem(
          title: "나의 성격은",
          list: ["적극적인", "열정적인", "예의바른", "자유로운", "쿨한"]
        ),
        ClipItem(
          title: "내가 푹 빠진 취미는",
          list: ["코인노래방", "헬스", "드라이브", "만화 웹툰 정주행", "자전거"]
        )
      ]
    )
    .padding(.horizontal, .xl)
  }
}

#Preview {
  ClipListContainerViewTest()
}
