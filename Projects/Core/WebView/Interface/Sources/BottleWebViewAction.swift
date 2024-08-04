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
  case showTaost(mesage: String)
  /// 토큰 전송
  case tokenDidSend(accessToken: String, refreshToken: String)
  
  // MARK: - SignUp
  
  /// 회원가입 성공 콜백
  case signUpComplted(accessToken: String, refreshToken: String)
  
  // MARK: - LogIn
  
  /// 로그인 성공
  case loginDidCompleted(accessToken: String, refreshToken: String)
  
  // MARK: - Onboarding(Create Profile)
  
  /// 프로필 작성 완료
  case createProfileDidCompleted
  
  // MARK: - Arrived Bottle
  
  /// 문답 시작하기(보틀 수락)
  case bottelDidAccepted
  
  // MARK: - My Page
  
  /// 로그아웃 성공
  case logoutDidCompleted
  /// 회원탈퇴
  case withdrawalDidCompleted
  
  public init?(
    type: String,
    message: String? = nil,
    accessToken: String? = nil,
    refreshToken: String? = nil
  ) {
    switch type {
      
    // MARK: - General
      
    case "onWebViewClose":
      self = .closeWebView
    case "onToastOpen":
      self = .showTaost(mesage: message ?? "")
    case "onTokenSend":
      self = .tokenDidSend(
        accessToken: accessToken ?? "",
        refreshToken: refreshToken ?? ""
      )
      
    // MARK: - SignUp
      
    case "onSignup":
      self = .signUpComplted(
        accessToken: accessToken ?? "",
        refreshToken: refreshToken ?? ""
      )
      
    // MARK: - LogIn
      
    case "onLogin":
      self = .loginDidCompleted(
        accessToken: accessToken ?? "",
        refreshToken: refreshToken ?? ""
      )
            
    // MARK: - Onboarding(Create Profile)
      
    case "onCreateProfileComplete":
      self = .createProfileDidCompleted
      
    // MARK: - Arrived Bottle
      
    case "onBottleAccept":
      self = .bottelDidAccepted
      
    // MARK: - My Page
      
    case "logout":
      self = .logoutDidCompleted
      
    case "deleteUser":
      self = .withdrawalDidCompleted
      
    default:
      return nil
    }
  }
}
