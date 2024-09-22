//
//  BottleURLType.swift
//  CoreURLHandlerInterface
//
//  Created by JongHoon on 9/20/24.
//

import Foundation

public enum BottleURLType {
  case bottleAppStore
  case bottleAppLookUp
  case kakaoChannelTalk
  
  public var url: URL {
    switch self {
    case .bottleAppStore:
      return URL(string: Bundle.main.infoDictionary?["APP_STORE_URL"] as? String ?? "")!

    case .kakaoChannelTalk:
      return URL(string: Bundle.main.infoDictionary?["KAKAO_CHANNEL_TALK_URL"] as? String ?? "")!
      
    case .bottleAppLookUp:
      return URL(string: Bundle.main.infoDictionary?["APP_LOOK_UP_URL"] as? String ?? "")!
    }
  }
}
