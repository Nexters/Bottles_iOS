//
//  PhotoShareStateType.swift
//  DesignSystemExample
//
//  Created by 임현규 on 8/9/24.
//

import Foundation

public enum PhotoShareStateType: Equatable {
  /// 아직 선택 전
  case notSelected
  
  /// 상대방 공개 O, 본인 공개 O
  case bothPublic(peerProfileImageURL: String, myProfileImageURL: String)
  
  /// 상대방 공개 X or 본인 공개 X
  case eitherPrivate
  
  /// 상대방 아직 선택 X, 본인 공개 O
  case waitingForPeer
  
  public var peerProfileImageURL: String? {
    switch self {
    case .bothPublic(let peerProfileImageURL, _):
      return peerProfileImageURL
    default:
      return nil
    }
  }

  public var myProfileImageURL: String? {
    switch self {
    case .bothPublic(_, let myProfileImageURL):
      return myProfileImageURL
    default:
      return nil
    }
  }
}
