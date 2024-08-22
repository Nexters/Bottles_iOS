//
//  BaseWebViewType.swift
//  FeatureBaseWebViewInterface
//
//  Created by JongHoon on 8/9/24.
//

import Foundation

import CoreWebViewInterface
import CoreKeyChainStoreInterface
import CoreKeyChainStore

public enum BottleWebViewType: String {
  private var baseURL: String {
    (Bundle.main.infoDictionary?["WEB_VIEW_BASE_URL"] as? String) ?? ""
  }
  
  case createProfile = "create-profile"
  case myPage = "my"
  case signUp = "signup"
  case login
  case bottles
  
  public var url: URL {
    switch self {
    case .createProfile:
      return makeUrlWithToken(rawValue)
      
    case .myPage:
      return makeUrlWithToken(rawValue)
      
    case .signUp:
      return URL(string: baseURL + "/" + rawValue)!
      
    case .login:
      return URL(string: baseURL + "/" + rawValue)!
      
    case .bottles:
      return makeUrlWithToken(rawValue)
    }
  }
  
  public var messageHandler: WebViewMessageHandler {
    switch self {
    default:
      return .default
    }
  }
}

// MARK: - private methods
private extension BottleWebViewType {
  func makeUrlWithToken(_ path: String) -> URL {
    var components = URLComponents(string: baseURL)
    components?.path = "/\(path)"
    components?.queryItems = [
      URLQueryItem(name: "accessToken", value: KeyChainTokenStore.shared.load(property: .accessToken)),
      URLQueryItem(name: "refreshToken", value: KeyChainTokenStore.shared.load(property: .refreshToken))
    ]
    
    return (components?.url)!
  }
}
