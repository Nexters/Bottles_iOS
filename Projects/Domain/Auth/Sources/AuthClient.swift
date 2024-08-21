//
//  AuthClient.swift
//  DomainAuth
//
//  Created by 임현규 on 7/31/24.
//

import Foundation

import DomainAuthInterface
import CoreNetwork
import CoreLoggerInterface

import ComposableArchitecture
import Moya

extension AuthClient: DependencyKey {
  public static var liveValue: AuthClient = .live()
  private static func live() -> AuthClient {
    @Dependency(\.network) var networkManager
    @Dependency(\.loginManager) var loginManager
    
    return .init(
      signInWithKakao: {
        let signInResult = try await loginManager.signIn(loginType: .kakao)
        let accessToken = signInResult.accessToken
        guard let fcmToken = UserDefaults.standard.string(forKey: "fcmToken")
        else {
          Log.fault("no fcm token")
          fatalError()
        }
        let data = SignInRequestDTO(code: accessToken, fcmDeviceToken: fcmToken)
        let responseData = try await networkManager.reqeust(api: .apiType(AuthAPI.kakao(data)), dto: SignInResponseDTO.self)
        let userInfo = responseData.toDomain()
        return userInfo
      },
      
      signInWithApple: {
        // TODO: apple Login API로 수정
        let signInResult = try await loginManager.signIn(loginType: .apple)
        let accessToken = signInResult.accessToken
        let userName = signInResult.userName
        
        guard let fcmToken = UserDefaults.standard.string(forKey: "fcmToken")
        else {
          Log.fault("no fcm token")
          fatalError()
        }
        let data = SignInRequestDTO(code: accessToken, fcmDeviceToken: fcmToken)
        let responseData = try await networkManager.reqeust(api: .apiType(AuthAPI.apple(data)), dto: SignInResponseDTO.self)
        var userInfo = responseData.toDomain()
        userInfo.userName = userName
        return userInfo
      },
      saveToken: { token in
        LocalAuthDataSourceImpl.saveToken(token: token)
      },
      checkTokenIsExist: {
        LocalAuthDataSourceImpl.checkTokeinIsExist()
      },
      withdraw: {
        try await networkManager.reqeust(api: .apiType(AuthAPI.withdraw))
      },
      logout: {
        guard let fcmToken = UserDefaults.standard.string(forKey: "fcmToken")
        else {
          Log.fault("no fcm token")
          return
        }
        try await networkManager.reqeust(api: .apiType(AuthAPI.logout(LogOutRequestDTO(fcmDeviceToken: fcmToken))))
      },
      refreshAppleToken: {
        let appleToken = try await networkManager.reqeust(api: .apiType(AppleAuthAPI.refreshToken), dto: AppleTokenResponseDTO.self).toDomain()
        return appleToken
      },
      revokeAppleLogin: {
        try await networkManager.reqeust(api: .apiType(AppleAuthAPI.revoke))
      },
      fetchAppleClientSecret: {
        let responseData = try await networkManager.reqeust(api: .apiType(AuthAPI.revoke), dto: ClientSecretResponseDTO.self)
        let clientSecret = responseData.clientSecret
        return clientSecret
      },
      registerUserProfile: { userName in
        let requestDTO = ProfileRequestDTO(name: userName)
        try await networkManager.reqeust(api: .apiType(AuthAPI.profile(requestDTO)))
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
