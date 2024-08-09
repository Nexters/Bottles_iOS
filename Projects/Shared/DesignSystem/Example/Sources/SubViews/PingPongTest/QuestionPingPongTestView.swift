//
//  QuestionPingPongTestView.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 8/9/24.
//

import SwiftUI
import SharedDesignSystem

public struct QuestionPingPongTestView: View {
  @State var textFieldState: TextFieldState = .enabled
  @State var text: String = ""
  
  public init() {}
  
  public var body: some View {
    ScrollView {
      VStack(spacing: 30) {
        QuestionPingPongView(
          pingpongTitle: "상대방 X, 본인 O",
          isActive: true,
          questionContent: "Q. 기념일은 어떻게 챙기는 편인가요?",
          questionState: .selfAnswered(mySelf: "어떤 날은 아침에 눈이 번쩍 떠지는 게 힘이 펄펄 나는 것 같은가 하면 또 어떤 날은 몸이 진흙으로 만들어진 것 같은 때가 있습니다. 몸이 힘들면 마음이 가라앉기 마련입니다"))
        
        QuestionPingPongView(
          pingpongTitle: "상대방 X 본인 X",
          textFieldContent: $text,
          textFieldState: .constant(.enabled),
          isActive: true,
          questionContent: "Q. 기념일은 어떻게 챙기는 편인가요?",
          questionState: .noAnswer)
        
        QuestionPingPongView(
          pingpongTitle: "상대방 O 본인 O",
          isActive: true,
          questionContent: "Q. 기념일은 어떻게 챙기는 편인가요?",
          questionState: .bothAnswered(peer: "어떤 날은 아침에 눈이 번쩍 떠지는 게 힘이 펄펄 나는 것 같은가 하면 또 어떤 날은 몸이 진흙으로 만들어진 것 같은 때가 있습니다. 몸이 힘들면 마음이 가라앉기 마련입니다", mySelf: "어떤 날은 아침에 눈이 번쩍 떠지는 게 힘이 펄펄 나는 것 같은가 하면 또 어떤 날은 몸이 진흙으로 만들어진 것 같은 때가 있습니다. 몸이 힘들면 마음이 가라앉기 마련입니다"))
        
        QuestionPingPongView(
          pingpongTitle: "상대방 O 본인 X",
          textFieldContent: $text,
          textFieldState: .constant(.enabled),
          isActive: true,
          questionContent: "Q. 기념일은 어떻게 챙기는 편인가요?",
          questionState: .peerAnswered(peer: "어떤 날은 아침에 눈이 번쩍 떠지는 게 힘이 펄펄 나는 것 같은가 하면 또 어떤 날은 몸이 진흙으로 만들어진 것 같은 때가 있습니다. 몸이 힘들면 마음이 가라앉기 마련입니다"))
      }
    }
  }
}
