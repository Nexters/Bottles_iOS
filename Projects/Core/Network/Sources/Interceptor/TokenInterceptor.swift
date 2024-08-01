//
//  TokenInterceptor.swift
//  CoreNetwork
//
//  Created by 임현규 on 8/1/24.
//

import Foundation

import CoreKeyChainStore
import CoreLoggerInterface

import Alamofire
import Dependencies


public struct TokenInterceptor: RequestInterceptor {
  public static let shared = TokenInterceptor()
  private let lock = NSLock()
  
  public init() {}
  
  public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
    var urlRequest = urlRequest
    lock.lock()
    defer { lock.unlock() }
    
    if let pathComponents = urlRequest.url?.pathComponents, pathComponents.contains("refresh") {
      let refreshToken = KeyChainTokenStore.shared.load(property: .refreshToken)
      urlRequest.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
    } else {
      let accessToken = KeyChainTokenStore.shared.load(property: .accessToken)
      urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    }
    
    completion(.success(urlRequest))
  }
  
  public func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
    guard let response = request.task?.response as? HTTPURLResponse,
          response.statusCode == 401,
          let pathComponents = request.request?.url?.pathComponents,
          !pathComponents.contains("refresh") else {
      completion(.doNotRetryWithError(error))
      return
    }
    lock.lock()
    defer { lock.unlock() }
        
    @Dependency(\.network) var networkManager
        
    Task {
      do {
        let refreshToken = KeyChainTokenStore.shared.load(property: .refreshToken)
        networkManager.addAuthorizationHeader(token: refreshToken)
        let token = try await networkManager.reqeust(api: .apiType(RefreshAPI.refresh), dto: RefreshResponseDTO.self)
        
        guard let accessToken = token.accessToken,
              let refreshToken = token.refreshToken else {
          completion(.doNotRetry)
          return
        }
        
        KeyChainTokenStore.shared.save(property: .accessToken, value: accessToken)
        KeyChainTokenStore.shared.save(property: .refreshToken, value: refreshToken)
        completion(.retry)
      } catch {
        completion(.doNotRetry)
      }
    }
  }
}
