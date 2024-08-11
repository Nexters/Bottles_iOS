//
//  BottlePingPongResponseDTO.swift
//  DomainBottleInterface
//
//  Created by JongHoon on 8/11/24.
//

import Foundation

struct BottlePingPongResponseDTO: Decodable {
  let introduction: [IntroductionDTO]?
  let isStopped: Bool?
  let letters: [LetterDTO]?
  let matchResult: MatchResultDTO?
  let photo: PhotoDTO?
  let stopUserName: String?
  let userProfile: UserProfileDTO?
  
  struct IntroductionDTO: Codable {
    let answer: String?
    let question: String?
  }
  
  struct LetterDTO: Codable {
    let canshow, isDone: Bool?
    let myAnswer: String?
    let order: Int?
    let otherAnswer, question: String?
    let shouldAnswer: Bool?
  }
    
  struct MatchResultDTO: Codable {
    let isFirstSelect: Bool?
    let isMatched: Bool?
    let otherContact: String?
    let shouldAnswer: Bool?
  }
  
  struct PhotoDTO: Codable {
    let isDone: Bool?
    let myAnswer: Bool?
    let myImageURL: String?
    let otherAnswer: Bool?
    let otherImageURL: String?
    let shouldAnswer: Bool?
    
    enum CodingKeys: String, CodingKey {
      case isDone
      case myAnswer
      case myImageURL = "myImageUrl"
      case otherAnswer
      case otherImageURL = "otherImageUrl"
      case shouldAnswer
    }
  }
  
  struct UserProfileDTO: Codable {
    let age: Int?
    let profileSelect: ProfileSelectDTO?
    let userImageURL: String?
    let userName: String?
    
    enum CodingKeys: String, CodingKey {
      case age
      case profileSelect
      case userImageURL = "userImageUrl"
      case userName
    }
    
    struct ProfileSelectDTO: Codable {
      let alcohol: String?
      let height: Int?
      let interest: InterestDTO?
      let job: String?
      let keyword: [String]?
      let mbti: String?
      let region: RegionDTO?
      let religion: String?
      let smoking: String?
      
      struct InterestDTO: Codable {
        let culture: [String]?
        let entertainment: [String]?
        let etc: [String]?
        let sports: [String]?
      }
      
      struct RegionDTO: Codable {
        let city: String?
        let state: String?
      }
    }
  }
}
