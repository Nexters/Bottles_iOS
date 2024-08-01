//
//  Provider.swift
//  CoreNetworkInterface
//
//  Created by 임현규 on 7/22/24.
//

import Foundation
import CoreNetworkInterface
import Moya

final class Provider<APIType: BaseTargetType>: Providable {
  private var moyaProvider: MoyaProvider<APIType>
  
  public init(moyaProvider: MoyaProvider<APIType>) {
    self.moyaProvider = moyaProvider
  }

  public init() {    
    self.moyaProvider = MoyaProvider<APIType>.init(
      session: Session(interceptor: TokenInterceptor.shared),
      plugins: [MoyaLoggerPlugin()]
    )
  }
  
  func reqeust(api: APIType) async throws -> Response {
    return try await withCheckedThrowingContinuation { continuation in
      moyaProvider.request(api) { result in
        switch result {
        case let .success(response) where 200..<300 ~= response.statusCode:
          continuation.resume(returning: response)
        case let .success(response) where 300... ~= response.statusCode:
          continuation.resume(throwing: MoyaError.statusCode(response))
        case let .failure(error):
          continuation.resume(throwing: error)
        default:
          let error = NSError(domain: "Unkowned Error", code: 0)
          continuation.resume(throwing: error)
        }
      }
    }
  }
  
  func addAuthorizationHeader(token: String) {
    let provider = MoyaProvider<APIType>(
      endpointClosure: endpointClouser(token: token),
      session: Session(interceptor: TokenInterceptor.shared),
      plugins: [MoyaLoggerPlugin()]
    )
    
    moyaProvider = provider
  }
}

// MARK: - Private Extension
private extension Provider {
  func endpointClouser(token: String) -> MoyaProvider<APIType>.EndpointClosure {
    return { (targetType: APIType) -> Endpoint in
      var endpoint = MoyaProvider.defaultEndpointMapping(for: targetType)
      endpoint = endpoint.adding(newHTTPHeaderFields: ["Authorization": "Bearer \(token)"])
      return endpoint
    }
  }
}


