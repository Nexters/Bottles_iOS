//
//  ProfileStatusResponseDTO.swift
//  DomainProfileInterface
//
//  Created by 임현규 on 8/18/24.
//

import Foundation

public struct ProfileStatusResponseDTO: Decodable {
  let userProfileStatus: String?
  
  public func toDomain() -> UserProfileStatus {
    switch userProfileStatus {
    case "EMPTY":
      return .empty
    case "ONLY_PROFILE_CREATED":
      return .doneProfileSelect
    case "INTRODUCE_DONE":
      return .doneIntroduction
    case "PHOTO_DONE":
      return .doneProfileImage
    default:
      return .empty
    }
  }
}
