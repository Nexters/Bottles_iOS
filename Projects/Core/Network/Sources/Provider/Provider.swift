//
//  Provider.swift
//  CoreNetworkInterface
//
//  Created by 임현규 on 7/22/24.
//

import Foundation
import CoreNetworkInterface
import Moya

struct Provider<APIType: BaseTargetType>: Providable {
  private let moyaProvider: MoyaProvider<APIType>
  
  public init(moyaProvider: MoyaProvider<APIType>) {
    self.moyaProvider = moyaProvider
  }

  public init() {
    self.moyaProvider = MoyaProvider<APIType>(plugins: [MoyaLoggerPlugin()])
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
}
