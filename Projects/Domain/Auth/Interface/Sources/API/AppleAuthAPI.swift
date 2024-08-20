//
//  AppleAuthAPI.swift
//  DomainAuthInterface
//
//  Created by 임현규 on 8/21/24.
//

import Foundation

import Moya

import CoreKeyChainStore
import CoreNetworkInterface

public enum AppleAuthAPI {
  case refreshToken
  case revoke
}

extension AppleAuthAPI: BaseTargetType {
    public var baseURL: URL {
        return URL(string: "https://appleid.apple.com/auth")!
    }
    
    public var path: String {
        switch self {
        case .refreshToken: return "/token"
        case .revoke:       return "/revoke"
        }
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    public var task: Moya.Task {
        switch self {
        case .refreshToken:
            let appleAuthCode = KeyChainTokenStore.shared.load(property: .AppleAuthCode)
            let clientSecret = KeyChainTokenStore.shared.load(property: .AppleClientSecret)
            let parameters: [String: Any] = [
                "client_id": "asia.bottles",
                "client_secret": clientSecret,
                "code": appleAuthCode,
                "grant_type": "authorization_code"
            ]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .revoke:
            let appleRefreshToken = KeyChainTokenStore.shared.load(property: .AppleRefreshToken)
            let clientSecret = KeyChainTokenStore.shared.load(property: .AppleClientSecret)
            let parameters: [String: Any] = [
                "client_id": "asia.bottles",
                "client_secret": clientSecret,
                "token": appleRefreshToken
            ]
        
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }
}
