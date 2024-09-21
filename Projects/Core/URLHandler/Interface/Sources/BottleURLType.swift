//
//  BottleURLType.swift
//  CoreURLHandlerInterface
//
//  Created by JongHoon on 9/20/24.
//

import Foundation

public enum BottleURLType {
  case bottleAppStore
  
  public var url: URL {
    switch self {
    case .bottleAppStore:
      return URL(string: Bundle.main.infoDictionary?["APP_STORE_URL"] as? String ?? "")!
    }
  }
}
