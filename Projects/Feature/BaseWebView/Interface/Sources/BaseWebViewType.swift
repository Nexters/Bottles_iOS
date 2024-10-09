//
//  BaseWebViewType.swift
//  FeatureBaseWebViewInterface
//
//  Created by JongHoon on 8/9/24.
//

import Foundation

import DomainApplicationInterface
import DomainApplication

import CoreWebViewInterface
import CoreKeyChainStoreInterface
import CoreKeyChainStore
import CoreLoggerInterface

import Dependencies

public enum BottleWebViewType {
  private var baseURL: String {
    (Bundle.main.infoDictionary?["WEB_VIEW_BASE_URL"] as? String) ?? ""
  }
  
  case createProfile
  case signUp
  case login
  case bottleArrival
  case editProfile
  case goodFeeling
  case openURL(url: String)
  
  var path: String {
    switch self {
    case .createProfile:
      return "create-profile"
    case .signUp:
      return "signup"
    case .login:
      return "login"
    case .bottleArrival:
      return "bottles/recommendations"
    case .editProfile:
      return "profile/edit"
    case .goodFeeling:
      return "bottles/sents"
    case .openURL:
      return ""
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
      
    case .bottleArrival:
      return makeUrlWithToken(path)
      
    case .editProfile:
      return makeUrlWithToken(path)
      
    case .goodFeeling:
      return makeUrlWithToken(path)
      
    case let .openURL(url):
      return URL(string: url)!
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
    @Dependency(\.applicationClient) var applicationClient
    
    var components = URLComponents(string: baseURL)
    components?.path = "/\(path)"
    components?.queryItems = [
      URLQueryItem(name: "accessToken", value: KeyChainTokenStore.shared.load(property: .accessToken)),
      URLQueryItem(name: "refreshToken", value: KeyChainTokenStore.shared.load(property: .refreshToken)),
      URLQueryItem(name: "device", value: "ios"),
      URLQueryItem(name: "version", value: applicationClient.fetchCurrentAppVersion())
    ]
    
    return (components?.url)!
  }
}
