//
//  UserProfileTestView.swift
//  DesignSystemExample
//
//  Created by 임현규 on 8/7/24.
//

import SwiftUI
import SharedDesignSystem

public struct UserProfileTestView: View {
  public init() {}
    public var body: some View {
      
      VStack(spacing: .xl) {
        UserProfileView(
          imageURL: "https://static.wikia.nocookie.net/wallaceandgromit/images/3/38/Gromit-3.png/revision/latest/scale-to-width/360?cb=20191228190308",
          userName: "임현규",
          userAge: 26
        )
        .border(.red)
        
        UserProfileView(
          imageURL: "",
          userName: "임현규",
          userAge: 26
        )
        .border(.red)
      }
    }
}

#Preview {
    UserProfileTestView()
}
