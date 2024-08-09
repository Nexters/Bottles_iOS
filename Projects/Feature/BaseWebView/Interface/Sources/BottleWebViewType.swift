//
//  BottleWebViewType.swift
//  CoreUtilInterface
//
//  Created by JongHoon on 8/2/24.
//

import Foundation

import CoreWebViewInterface
import CoreKeyChainStoreInterface
import CoreKeyChainStore

public enum BottleWebViewType {
  private var baseURL: String {
    (Bundle.main.infoDictionary?["WEB_VIEW_BASE_URL"] as? String) ?? ""
  }
  
  case createProfile
  case myPage
  case signUp
  case login
  // TODO: 도착한 보틀 추가
  
  public var url: URL {
    var components = URLComponents(string: baseURL)
    switch self {
    case .createProfile:
      components?.path = "/create-profile"
      components?.queryItems = [
        URLQueryItem(name: "accessToken", value: KeyChainTokenStore.shared.load(property: .accessToken)),
        URLQueryItem(name: "refreshToken", value: KeyChainTokenStore.shared.load(property: .refreshToken))
      ]
      return (components?.url)!
      
    case .myPage:
      components?.path = "/my"
      components?.queryItems = [
        URLQueryItem(name: "accessToken", value: KeyChainTokenStore.shared.load(property: .accessToken)),
        URLQueryItem(name: "refreshToken", value: KeyChainTokenStore.shared.load(property: .refreshToken))
      ]
      return (components?.url)!
      
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
