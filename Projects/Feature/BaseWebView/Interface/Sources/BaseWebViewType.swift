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

public enum BottleWebViewType {
  private var baseURL: String {
    (Bundle.main.infoDictionary?["WEB_VIEW_BASE_URL"] as? String) ?? ""
  }
  
  case createProfile
  case signUp
  case login
  case bottles
  case editProfile
  
  var path: String {
    switch self {
    case .createProfile:
      return "create-profile"
    case .signUp:
      return "signup"
    case .login:
      return "login"
    case .bottles:
      return "bottles"
    case .editProfile:
      return "profile/edit"
    }
  }
  
  public var url: URL {
    switch self {
    case .createProfile:
      return makeUrlWithToken(path)
      
    case .signUp:
      return URL(string: baseURL + "/" + path)!
      
    case .login:
      return URL(string: baseURL + "/" + path)!
      
    case .bottles:
      return makeUrlWithToken(path)
      
    case .editProfile:
      return makeUrlWithToken(path)
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
