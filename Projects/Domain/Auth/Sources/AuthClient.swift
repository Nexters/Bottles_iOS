//
//  AuthClient.swift
//  DomainAuth
//
//  Created by 임현규 on 7/31/24.
//

import Foundation

import DomainAuthInterface
import CoreNetwork

import ComposableArchitecture
import Moya

extension AuthClient: DependencyKey {
  public static var liveValue: AuthClient = .live()
  private static func live() -> AuthClient {
    @Dependency(\.network) var networkManager
    @Dependency(\.loginManager) var loginManager
    
    return .init(
      signInWithKakao: {
        let accessToken = try await loginManager.signIn(loginType: .kakao)
        let data = SignInRequestDTO(code: accessToken)
        let responseData = try await networkManager.reqeust(api: .apiType(AuthAPI.kakao(data)), dto: SignInResponseDTO.self)
        return responseData
      },
      
      signInWithApple: {
        // TODO: apple Login API로 수정
        let accessToken = try await loginManager.signIn(loginType: .apple)
        let data = SignInRequestDTO(code: accessToken)
        let responseData = try await networkManager.reqeust(api: .apiType(AuthAPI.apple(data)), dto: SignInResponseDTO.self)
        return responseData
      },
      saveToken: { token in
        LocalAuthDataSourceImpl.saveToken(token: token)
      },
      checkTokenIsExist: {
        LocalAuthDataSourceImpl.checkTokeinIsExist()
      },
      logout: {
        try await networkManager.reqeust(api: .apiType(AuthAPI.logout))
      },
      withdraw: {
        try await networkManager.reqeust(api: .apiType(AuthAPI.withdraw))
      }
    )
  }
}

extension DependencyValues {
  public var authClient: AuthClient {
    get { self[AuthClient.self] }
    set { self[AuthClient.self] = newValue }
  }
}
