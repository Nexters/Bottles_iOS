//
//  BottleWebViewType.swift
//  CoreUtilInterface
//
//  Created by JongHoon on 8/2/24.
//

import Foundation

public enum BottleWebViewType {
  private var baseURL: String {
    (Bundle.main.infoDictionary?["WEB_VIEW_BASE_URL"] as? String) ?? ""
  }
  
  case createProfile
  case myPage
  case signUp
  case login
  
  public var url: URL {
    switch self {
    case .createProfile:
      return URL(string: baseURL + "/create-profile")!
    case .myPage:
      return URL(string: baseURL + "/my")!
    case .signUp:
      return URL(string: baseURL + "/signup")!
    case .login:
      return URL(string: baseURL + "/login")!
    }
  }
  
  public var messageHandler: WebViewMessageHandler {
    switch self {
    default:
      return .default
    }
  }
}
