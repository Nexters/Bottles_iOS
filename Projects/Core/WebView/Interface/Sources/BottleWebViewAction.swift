//
//  BottleWebViewAction.swift
//  CoreWebViewInterface
//
//  Created by JongHoon on 8/3/24.
//

import CoreLoggerInterface

public enum BottleWebViewAction: Equatable {
  // MARK: - General
  
  /// 웹뷰 종료 호출
  case closeWebView
  /// 토스트 호출
  case showTaost(message: String)
  /// 토큰 전송
  case tokenDidSend(accessToken: String, refreshToken: String)
  /// web view loading 완료
  case webViewLoadingDidCompleted
  
  // MARK: - SignUp
  
  /// 회원가입 성공 콜백
  case signUpDidComplted(accessToken: String, refreshToken: String)
  /// 외부 링크 이동
  case openLink(href: String)
  
  // MARK: - LogIn
  
  /// 로그인 성공
  case loginDidCompleted(accessToken: String, refreshToken: String, isCompletedOnboardingIntroduction: Bool)
  
  // MARK: - Onboarding(Create Profile)
  
  /// 프로필 작성 완료
  case createProfileDidCompleted
  
  // MARK: - Arrived Bottle
  
  /// 문답 시작하기(보틀 수락)
  case bottelDidAccepted
  
  // MARK: - My Page
  
  /// 로그아웃
  case logOutButtonDidTapped
  /// 회원탈퇴
  case withdrawalButtonDidTap
  
  public init?(
    type: String,
    message: String? = nil,
    accessToken: String? = nil,
    refreshToken: String? = nil,
    href: String? = nil,
    isCompletedOnboardingIntroduction: Bool? = nil
  ) {
    switch type {
      
    // MARK: - General
      
    case "onWebViewClose":
      self = .closeWebView
    case "onToastOpen":
      self = .showTaost(message: message ?? "")
    case "onTokenSend":
      guard let accessToken,
            let refreshToken
      else {
        Log.assertion(
          message: "accessToken: \(String(describing: accessToken)), refreshToken: \(String(describing: refreshToken))"
        )
        return nil
      }
      self = .tokenDidSend(
        accessToken: accessToken,
        refreshToken: refreshToken
      )
      
    // MARK: - SignUp
      
    case "onSignup":
      guard let accessToken,
            let refreshToken
      else {
        Log.assertion(
          message: "accessToken: \(String(describing: accessToken)), refreshToken: \(String(describing: refreshToken))"
        )
        return nil
      }
      self = .signUpDidComplted(
        accessToken: accessToken,
        refreshToken: refreshToken
      )
    case "openLink":
      guard let href
      else {
        Log.assertion(
          message: "openLink: \(String(describing: href))"
        )
        return nil
      }
      self = .openLink(href: href)
      
      
      
    // MARK: - LogIn
      
    case "onLogin":
      guard let accessToken,
            let refreshToken,
            let isCompletedOnboardingIntroduction
      else {
        Log.assertion(
          message: "accessToken: \(String(describing: accessToken)), refreshToken: \(String(describing: refreshToken)), isCompletedOnboardingIntroduction: \(String(describing: isCompletedOnboardingIntroduction))"
        )
        return nil
      }
      // TODO: 웹뷰 값 변경되면 isCompletedOnboardingIntroduction 실제값 넣어줘야함
      self = .loginDidCompleted(
        accessToken: accessToken,
        refreshToken: refreshToken,
        isCompletedOnboardingIntroduction: isCompletedOnboardingIntroduction
      )
            
    // MARK: - Onboarding(Create Profile)
      
    case "onCreateProfileComplete":
      self = .createProfileDidCompleted
      
    // MARK: - Arrived Bottle
      
    case "onBottleAccept":
      self = .bottelDidAccepted
      
    // MARK: - My Page
      
    case "logout":
      self = .logOutButtonDidTapped
      
    case "deleteUser":
      self = .withdrawalButtonDidTap
      
    default:
      return nil
    }
  }
}
