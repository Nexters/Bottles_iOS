//
//  ProfileResponseDTO.swift
//  DomainProfileInterface
//
//  Created by 임현규 on 7/29/24.
//

import Foundation

// MARK: - Profile
public struct ProfileResponseDTO: Decodable {
  public let userName: String?
  public let age: Int?
  public let introduction: [IntroductionDTO]?
  public let profileSelect: ProfileSelectDTO?
  
  // MARK: - Introduction
  public struct IntroductionDTO: Decodable {
    let answer, question: String?
  }

  // MARK: - ProfileSelect
  public struct ProfileSelectDTO: Decodable {
    let alcohol: String?
    let height: Int?
    let interest: InterestDTO?
    let job: String?
    let keyword: [String]?
    let mbti: String?
    let region: RegionDTO?
    let religion, smoking: String?
    
    public func toDomain() -> UserProfile {
      return .init(
        mbti: mbti ?? "",
        keyword: keyword ?? [],
        interset: interest?.toDomain() ?? 
        UserInterest(culture: [], sports: [], entertainment: [], etc: []),
        job: job ?? "",
        smoke: smoking ?? "",
        alcohol: alcohol ?? "",
        height: height ?? 0,
        region: region?.toDomain() ??
        UserRegion(city: "", state: "")
      )
    }
  }

  // MARK: - Interest
  struct InterestDTO: Decodable {
    let culture, entertainment, etc, sports: [String]?
    
    public func toDomain() -> UserInterest {
      return .init(
        culture: culture,
        sports: sports,
        entertainment: entertainment,
        etc: etc)
    }
  }

  // MARK: - Region
  struct RegionDTO: Decodable {
    let city, state: String?
    
    func toDomain() -> UserRegion {
      return .init(
        city: city ?? "",
        state: state ?? ""
      )
    }
  }
  
  public func toProfileDomain() -> UserProfile {
    guard let profileSelect = profileSelect else {
      return UserProfile(
        mbti: "",
        keyword: [],
        interset: UserInterest(
          culture: nil, 
          sports: nil,
          entertainment: nil,
          etc: nil
        ),
        job: "",
        smoke: "",
        alcohol: "",
        height: 0,
        region: UserRegion(
          city: "", 
          state: ""
        )
      )
    }
    return profileSelect.toDomain()
  }
}

