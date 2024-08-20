//
//  AppleLoginManager.swift
//  DomainAuth
//
//  Created by 임현규 on 8/20/24.
//

import Foundation
import AuthenticationServices

import CoreKeyChainStore

final class AppleLoginManager: NSObject, ASAuthorizationControllerDelegate {
  typealias IdentityCode = String
  
  private var continuation: CheckedContinuation<IdentityCode, Error>?
  
  func signInWithApple() async throws -> IdentityCode {
    try await withCheckedThrowingContinuation { continuation in
      let request = ASAuthorizationAppleIDProvider().createRequest()
      request.requestedScopes = [.fullName]
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
    KeyChainTokenStore.shared.save(property: .AppleUserID, value: user)
    KeyChainTokenStore.shared.save(property: .AppleAuthCode, value: authorizationCodeString)
    continuation?.resume(returning: decodedIdentityToken)
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

