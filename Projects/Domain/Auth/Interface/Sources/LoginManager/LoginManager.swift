//
//  LoginManager.swift
//  DomainAuth
//
//  Created by 임현규 on 8/2/24.
//

import Foundation

import CoreLoggerInterface

import ComposableArchitecture

public struct LoginManager {
  public enum LoginType {
    case kakao
    case apple
    case sms
  }
  
  private var signIn: (_ loginType: LoginType) async throws -> String

  public init(signIn: @escaping (_ loginType: LoginType) async throws -> String) {
    self.signIn = signIn
  }
  
  /// 로그인 타입에 따라 Provider로 부터 받은 AuthToken & AccessToken을 반환합니다.
  /// - Parameters:
  ///   - loginType: 로그인하는 Type
  public func signIn(loginType: LoginType) async throws -> String {
    try await signIn(loginType)
  }
}
