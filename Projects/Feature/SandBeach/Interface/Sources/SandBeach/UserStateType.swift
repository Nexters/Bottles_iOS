//
//  UserStateType.swift
//  FeatureSandBeachInterface
//
//  Created by 임현규 on 8/10/24.
//

import Foundation

public extension SandBeachFeature {
  enum UserStateType: Equatable {
    /// 자기소개 작성 X
    case noIntroduction
    /// 도착한 보틀 X
    case noBottle(time: Int)
    /// 새로 도착한 보틀 O
    case hasNewBottle(bottleCount: Int)
    /// 확인한 보틀 O
    case hasActiveBottle(bottleCount: Int)
    /// 아무 상태도 아님
    case none
    
    var title: String {
      switch self {
      case .noIntroduction:                   return "보틀에 오신 것을\n환영해요!"
      case .noBottle:                         return "아직 보틀을\n찾지 못했어요"
      case .hasNewBottle(let bottleCount):    return "\(bottleCount)개의 새로운\n보틀이 도착했어요"
      case .hasActiveBottle(let bottleCount): return "\(bottleCount)개의 보틀이\n남아있어요"
      case .none:                             return ""
      }
    }
    var popUpText: String {
      switch self {
      case .noIntroduction:     return "자기소개 작성 후 매칭을 받을 수 있어요"
      case .noBottle(let time): return time == 0 ? "보틀이 곧 도착해요": "\(time)시간 후 새로운 보틀이 도착해요"
      case .hasNewBottle:       return "보틀을 클릭해보세요"
      case .hasActiveBottle:    return "보틀을 클릭해보세요"
      case .none:               return ""
      }
    }
    
    var buttonText: String? {
      switch self {
      case .noIntroduction: return "자기소개 작성하기"
      default:              return nil
      }
    }
    
    var isEmptyBottle: Bool {
      switch self {
      case .noBottle: return true
      default:        return false
      }
    }
    
    var isHasNewBottle: Bool {
      if case .hasNewBottle = self { return true }
      return false
    }
    
    
    var isHasActiveBottle: Bool {
      if case .hasActiveBottle = self { return true }
      return false
    }
  }
}
