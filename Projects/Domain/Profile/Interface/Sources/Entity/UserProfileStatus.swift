//
//  UserProfileStatus.swift
//  DomainProfileInterface
//
//  Created by 임현규 on 8/18/24.
//

import Foundation

public enum UserProfileStatus {
  /// 프로필이 아무것도 작성되지 않음
  case empty
  /// 온보딩 프로필 키워드 선택까지 완료된 상태
  case doneProfileSelect
  /// 자기소개까지 작성 완료된 상태
  case doneIntroduction
  /// 프로필 이미지까지 완료된 상태
  case doneProfileImage
}
