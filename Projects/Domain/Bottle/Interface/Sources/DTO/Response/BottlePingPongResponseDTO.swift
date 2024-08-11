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
  
  struct IntroductionDTO: Decodable {
    let answer: String?
    let question: String?
  }
  
  struct LetterDTO: Decodable {
    let canshow: Bool?
    let isDone: Bool?
    let myAnswer: String?
    let order: Int?
    let otherAnswer: String?
    let question: String?
    let shouldAnswer: Bool?
  }
    
  struct MatchResultDTO: Decodable {
    let isFirstSelect: Bool?
    let isMatched: Bool?
    let otherContact: String?
    let shouldAnswer: Bool?
  }
  
  struct PhotoDTO: Decodable {
    let isDone: Bool?
    let myAnswer: Bool?
    let myImageUrl: String?
    let otherAnswer: Bool?
    let otherImageUrl: String?
    let shouldAnswer: Bool?
  }
  
  struct UserProfileDTO: Decodable {
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
    
    struct ProfileSelectDTO: Decodable {
      let alcohol: String?
      let height: Int?
      let interest: InterestDTO?
      let job: String?
      let keyword: [String]?
      let mbti: String?
      let region: RegionDTO?
      let religion: String?
      let smoking: String?
      
      struct InterestDTO: Decodable {
        let culture: [String]?
        let entertainment: [String]?
        let etc: [String]?
        let sports: [String]?
      }
      
      struct RegionDTO: Decodable {
        let city: String?
        let state: String?
      }
    }
  }
}
