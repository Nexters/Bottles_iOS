//
//  PhotoSharePingPongTestView.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 8/9/24.
//

import SwiftUI
import SharedDesignSystem

public struct PhotoSharePingPongTestView: View {
  @State var isSelctedYesButton: Bool = false
  @State var isSelctedNoButton: Bool = false
  
  public init() {}
    public var body: some View {
      ScrollView {
        VStack(spacing: .md) {
          PhotoSharePingPongView(
            isActive: true,
            pingPongTitle: "사진 공개",
            photoShareState: .notSelected,
            isSelctedYesButton: $isSelctedYesButton,
            isSelctedNoButton: $isSelctedNoButton
          )
          
          PhotoSharePingPongView(
            isActive: true,
            pingPongTitle: "사진 공개",
            photoShareState: .waitingForPeer
          )
          
          PhotoSharePingPongView(
            isActive: true,
            pingPongTitle: "사진 공개",
            photoShareState: .eitherPrivate
          )
          
          PhotoSharePingPongView(
            isActive: true,
            pingPongTitle: "사진 공개",
            photoShareState: .bothPublic(peerProfileImageURL: "", myProfileImageURL: "")
          )
        }
        .padding(.horizontal, .md)
      }
    }
}

#Preview {
    PhotoSharePingPongTestView()
}
