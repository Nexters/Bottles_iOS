//
//  FinalSelectStateType.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 8/9/24.
//

import Foundation

public enum FinalSelectStateType: Equatable {
  /// 아직 선택 전
  case notSelected
  /// 상대방 선택 X, 본인 선택 O
  case waitingForPeer
  /// 상대방 선택 O, 본인 선택 O
  case bothSelected
}
