//
//  BottlePingPongResponseDTO.swift
//  DomainBottleInterface
//
//  Created by JongHoon on 8/11/24.
//

import Foundation

public struct BottlePingPongResponseDTO: Decodable {
  let introduction: [IntroductionDTO]?
  let isStopped: Bool?
  let letters: [LetterDTO]?
  let matchResult: MatchResultDTO?
  let photo: PhotoDTO?
  let stopUserName: String?
  let userProfile: UserProfileDTO?
  
  public func toDomain() -> BottlePingPong {
    return .init(
      introduction: (introduction?.map { $0.toDomain() }) ?? [],
      isStopped: isStopped ?? true,
      letters: (letters?.map { $0.toDomain() }) ?? [],
      matchResult: matchResult?.toDomain() ?? MatchResult(
        isFirstSelect: false,
        matchStatus: .disabled,
        otherContact: "",
        shouldAnswer: false
      ),
      photo: photo?.toDomain() ?? Photo(photoStatus: .disabled),
      stopUserName: stopUserName,
      userProfile: userProfile?.toDomain() ?? UserProfile(
        userId: -1,
        age: -1,
        userName: ""
      )
    )
  }
  
  public struct IntroductionDTO: Decodable {
    let answer: String?
    let question: String?
    
    public func toDomain() -> QuestionAndAnswer {
      return .init(
        answer: answer ?? "",
        question: question ?? ""
      )
    }
  }
  
  public struct LetterDTO: Decodable {
    let canshow: Bool?
    let isDone: Bool?
    let myAnswer: String?
    let order: Int?
    let otherAnswer: String?
    let question: String?
    let shouldAnswer: Bool?
    
    public func toDomain() -> Letter {
      return .init(
        canshow: canshow,
        isDone: isDone ?? false,
        myAnswer: myAnswer,
        order: order,
        otherAnswer: otherAnswer,
        question: question,
        shouldAnswer: shouldAnswer ?? false
      )
    }
  }
    
  public struct MatchResultDTO: Decodable {
    let isFirstSelect: Bool?
    let matchStatus: String?
    let otherContact: String?
    let shouldAnswer: Bool?
    
    public func toDomain() -> MatchResult {
      let matchStatus: PingPongMatchStatus = switch matchStatus {
      case "NONE": .disabled
      case "REQUIRE_SELECT": .requireSelect
      case "WAITING_OTHER_ANSWER": .waitingOtherAnswer
      case "MATCH_FAILED": .matchFailed
      case "MATCH_SUCCEEDED": .matchSucceeded
      default: .disabled
      }
      
      return .init(
        isFirstSelect: isFirstSelect ?? false,
        matchStatus: matchStatus,
        otherContact: otherContact ?? "",
        shouldAnswer: shouldAnswer ?? false
      )
    }
  }
  
  public struct PhotoDTO: Decodable {
    let photoStatus: String?
    let myImageUrl: String?
    let otherImageUrl: String?
    
    public func toDomain() -> Photo {
      let photoStatus: PingPongPhotoStatus = switch photoStatus {
      case "BOTH_AGREE":
          .bothAgree
      case "MY_REJECT":
          .myReject
      case "NONE":
          .disabled
      case "OTHER_REJECT":
          .otherReject
      case "REQUIRE_SELECT_OTHER_SELECT":
          .requireSelect(otherSelected: true)
      case "REQUIRE_SELECT_OTHER_NOT_SELECT":
          .requireSelect(otherSelected: false)
      case "WAITING_OTHER_ANSWER":
          .waitingOtherAnswer
      default:
          .disabled
      }
      return .init(
        photoStatus: photoStatus,
        myImageURL: myImageUrl,
        otherImageURL: otherImageUrl
      )
    }
  }
  
  public struct UserProfileDTO: Decodable {
    let userId: Int?
    let age: Int?
    let profileSelect: ProfileSelectDTO?
    let userImageURL: String?
    let userName: String?
    
    enum CodingKeys: String, CodingKey {
      case userId
      case age
      case profileSelect
      case userImageURL = "userImageUrl"
      case userName
    }
    
    public func toDomain() -> UserProfile {
      return .init(
        userId: userId ?? -1,
        age: age ?? -1,
        profileSelect: profileSelect?.toDomain(),
        userImageURL: userImageURL,
        userName: userName ?? ""
      )
    }
    
    public struct ProfileSelectDTO: Decodable {
      let alcohol: String?
      let height: Int?
      let interest: InterestDTO?
      let job: String?
      let keyword: [String]?
      let mbti: String?
      let region: RegionDTO?
      let religion: String?
      let smoking: String?
      
      public func toDomain() -> ProfileSelect {
        return .init(
          alcohol: alcohol ?? "",
          height: height ?? -1,
          interest: interest?.toDomain() ?? Interest(
            culture: [],
            entertainment: [],
            etc: [],
            sports: []
          ),
          job: job ?? "",
          keyword: keyword ?? [],
          mbti: mbti ?? "",
          region: region?.toDomain() ?? Region(
            city: "",
            state: ""
          ),
          religion: religion ?? "",
          smoking: smoking ?? ""
        )
      }
      
      public struct InterestDTO: Decodable {
        let culture: [String]?
        let entertainment: [String]?
        let etc: [String]?
        let sports: [String]?
        
        public func toDomain() -> Interest {
          return .init(
            culture: culture ?? [],
            entertainment: entertainment ?? [],
            etc: etc ?? [],
            sports: sports ?? []
          )
        }
      }
      
      public struct RegionDTO: Decodable {
        let city: String?
        let state: String?
        
        public func toDomain() -> Region {
          return .init(
            city: city ?? "",
            state: state ?? ""
          )
        }
      }
    }
  }
}
