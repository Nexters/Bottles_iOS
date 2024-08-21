//
//  AppleLoginManager.swift
//  DomainAuth
//
//  Created by 임현규 on 8/20/24.
//

import Foundation
import AuthenticationServices

import DomainAuthInterface
import CoreKeyChainStore

final class AppleLoginManager: NSObject, ASAuthorizationControllerDelegate {
  
  private var continuation: CheckedContinuation<SignInResult, Error>?
  
  func signInWithApple() async throws -> SignInResult {
    try await withCheckedThrowingContinuation { [weak self] continuation in
      guard let self = self else { return }
      let request = ASAuthorizationAppleIDProvider().createRequest()
      request.requestedScopes = [.fullName, .email]
      let controller = ASAuthorizationController(authorizationRequests: [request])
      controller.performRequests()
      controller.delegate = self
      
      if self.continuation == nil {
        self.continuation = continuation
      }
    }
  }
  
  func authorizationController(
    controller: ASAuthorizationController,
    didCompleteWithAuthorization authorization: ASAuthorization
  ) {
    // TODO: - Domain Error 추가.
    
    guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
      let error = NSError(domain: "invalidCrendential", code: 0)
      continuation?.resume(throwing: error)
      continuation = nil
      return
    }
    
    guard let identityToken = credential.identityToken,
          let decodedIdentityToken = String(data: identityToken, encoding: .utf8) else {
      let error = NSError(domain: "invalidIdentityToken", code: 0)
      continuation?.resume(throwing: error)
      continuation = nil
      return
    }
    
    guard let authorizationCodeData = credential.authorizationCode,
          let authorizationCodeString = String(data: authorizationCodeData, encoding: .utf8) else {
      let error = NSError(domain: "invalidAuthorizationCode", code: 0)
      continuation?.resume(throwing: error)
      continuation = nil
      return
    }
    
    
    let user = credential.user
    let fullName = credential.fullName
    let name = (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
    
    KeyChainTokenStore.shared.save(property: .AppleUserID, value: user)
    KeyChainTokenStore.shared.save(property: .AppleAuthCode, value: authorizationCodeString)
    
    let signInResult = SignInResult(accessToken: decodedIdentityToken, userName: name)
    continuation?.resume(returning: signInResult)
    continuation = nil
  }
  
  func authorizationController(
    controller: ASAuthorizationController,
    didCompleteWithError error: any Error
  ) {
    let error = NSError(domain: error.localizedDescription, code: 0)
    continuation?.resume(throwing: error)
    continuation = nil
  }
}

