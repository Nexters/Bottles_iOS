//
//  ProfileImageUploadView.swift
//  FeatureProfileSetupInterface
//
//  Created by 임현규 on 8/5/24.
//

import SwiftUI

import SharedDesignSystem

public struct ProfileImageUploadView: View {
  public init() {}
  public var body: some View {
    ScrollView {
      GeometryReader { geometry in
        VStack(spacing: 0) {
          titleView
          imagePickerButton
            .frame(height: geometry.size.width)
            .padding(.bottom, .md)
          doneButton
        }
      }
      .padding(.horizontal, .md)
    }
  }
}

private extension ProfileImageUploadView {
  var titleView: some View {
    TitleView(
      pageInfo: PageInfo(nowPage: 2, totalCount: 2),
      title: "보틀에 담을 나의 사진을 골라주세요",
      caption: "가치관 문답을 마친 후 동의 하에 공개돼요"
    )
    .padding(.bottom, 32)
  }
  
  var imagePickerButton: some View {
    ImagePickerButton()
      .asThrottleButton(action: {})
  }
  
  var doneButton: some View {
    SolidButton(
      title: "완료",
      sizeType: .full,
      buttonType: .throttle,
      action: {}
    )
  }
}
