//
//  FinalSelectPingPongTestView.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 8/9/24.
//

import SwiftUI
import SharedDesignSystem

public struct FinalSelectPingPongTestView: View {
  @State var isSelctedYesButton: Bool = false
  @State var isSelctedNoButton: Bool = false
  
  public init() {}
  public var body: some View {
    ScrollView {
      VStack(spacing: .md) {
        FinalSelectPingPongView(
          isActive: true,
          pingPongTitle: "최종 선택", 
          finalSelectState: .notSelected,
          isSelctedYesButton: $isSelctedYesButton,
          isSelctedNoButton: $isSelctedNoButton,
          doneButtonAction: { print("tapped") }
        )
        
        FinalSelectPingPongView(
          isActive: true,
          pingPongTitle: "최종 선택",
          finalSelectState: .waitingForPeer)
        
        
        FinalSelectPingPongView(
          isActive: true,
          pingPongTitle: "최종 선택",
          finalSelectState: .bothSelected)
      }
    }
  }
}

