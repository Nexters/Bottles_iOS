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


public class TokenInterceptor: RequestInterceptor {
  public static let shared = TokenInterceptor()
  private var isRefreshing = false
  
  public init() {}
  
  public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
    var urlRequest = urlRequest
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
    
    // header에 있는 token과 Local token 불일치 -> retry
    let accessToken = "Bearer \(KeyChainTokenStore.shared.load(property: .accessToken))"
    let headerToken = request.request?.headers.dictionary["Authorization"]
    
    if accessToken != headerToken {
      completion(.retry)
      return
    }
    
    // 토큰 재발행 요청중인 경우 들어온 401 응답 -> retry
    if isRefreshing {
      completion(.retry)
      return
    }
    
    isRefreshing = true
    
    @Dependency(\.network) var networkManager
        
    Task {
      do {
        let token = try await networkManager.reqeust(api: .apiType(RefreshAPI.refresh), dto: RefreshResponseDTO.self)
        
        guard let newAccessToken = token.accessToken,
              let newRefreshToken = token.refreshToken else {
          completion(.doNotRetry)
          return
        }
        
        KeyChainTokenStore.shared.save(property: .accessToken, value: newAccessToken)
        KeyChainTokenStore.shared.save(property: .refreshToken, value: newRefreshToken)
        self.isRefreshing = false
        completion(.retry)
      } catch {
        completion(.doNotRetry)
      }
    }
  }
}
