//
//  QuestionStateType.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 8/9/24.
//

import Foundation

public enum QuestionStateType: Equatable {
  /// 상대방 답변 O, 본인 답변 X
  case peerAnswered(peer: String)
  /// 상대방 답변 O, 본인 답변 O
  case bothAnswered(peer: String, mySelf: String)
  /// 상대방 답변 X, 본인 답변 O
  case selfAnswered(mySelf: String)
  /// 상대방 답변 X, 본인 답변 X
  case noAnswer
  case none
  
  var peerAnswer: String? {
    switch self {
    case .peerAnswered(let peer):
      return peer
    case .bothAnswered(let peer, _):
      return peer
    default:
      return nil
    }
  }
  
  var myAnswer: String? {
    switch self {
    case .bothAnswered(_, let mySelf):
      return mySelf
    case .selfAnswered(let mySelf):
      return mySelf
    default:
      return nil
    }
  }
}
