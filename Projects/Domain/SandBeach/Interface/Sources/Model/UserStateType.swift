//
//  UserStateType.swift
//  DomainSandBeach
//
//  Created by 임현규 on 7/29/24.
//

import Foundation

public enum UserStateType {
  case noIntroduction  /// 자기소개 작성 X
  case noBottle        /// 도착한 보틀 X
  case hasBottle       /// 도착한 보틀 O
  
  var popUpText: String {
    switch self {
    case .noIntroduction: return "자기소개 작성 후 열어볼 수 있어요"
    case .noBottle:       return "n시간 후 새로운 보틀이 도착해요"
    case .hasBottle:      return "새로운 보틀이 도착했어요"
    }
  }
  
  var buttonText: String? {
    switch self {
    case .noIntroduction: return "자기소개 작성하기"
    default:              return nil
    }
  }
}
