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
  }

  // MARK: - Interest
  struct InterestDTO: Decodable {
    let culture, entertainment, etc, sports: [String]?
  }

  // MARK: - Region
  struct RegionDTO: Decodable {
    let city, state: String?
  }
}

