//
//  NetworkManager.swift
//  CoreNetworkInterface
//
//  Created by 임현규 on 7/22/24.
//

import Foundation
import CoreNetworkInterface
import ComposableArchitecture

// MARK: - NetworkManagagner

public struct NetworkManager {
  public typealias APIType = AnyAPIType

  private let provider: any Providable<APIType>
  
  public let jsonDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
  }()
  
  public init(_ provider: any Providable<APIType>) {
    self.provider = provider
  }
  
  public init() {
    self.provider = Provider<APIType>()
  }
}

// MARK: - NetworkManagable

extension NetworkManager: NetworkManagable {
  public func reqeust<T>(api: APIType, dto: T.Type) async throws -> T where T : Decodable {
    let response = try await provider.reqeust(api: api)
    let data = try jsonDecoder.decode(dto, from: response.data)
    return data
  }
  
  public func reqeust(api: APIType) async throws {
    _ = try await provider.reqeust(api: api)
  }
  
  public func addAuthorizationHeader(token: String) {
    provider.addAuthorizationHeader(token: token)
  }
}

// MARK: - DependencyValues

extension DependencyValues {
  public var network: NetworkManager {
    get { self[NetworkManager.self] }
    set { self[NetworkManager.self] = newValue }
  }
}

// MARK: - DependencyKey

extension NetworkManager: DependencyKey {
  public static var liveValue: NetworkManager = NetworkManager()
}
