//
//  RefreshResponseDTO.swift
//  CoreNetwork
//
//  Created by 임현규 on 8/1/24.
//

import Foundation

public struct RefreshResponseDTO: Decodable {
  public let accessToken: String?
  public let refreshToken: String?
}

