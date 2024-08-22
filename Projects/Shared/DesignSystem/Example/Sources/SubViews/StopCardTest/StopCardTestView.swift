//
//  StopCardTestView.swift
//  DesignSystemExample
//
//  Created by 임현규 on 8/7/24.
//

import SwiftUI

import SharedDesignSystem

struct StopCardTestView: View {
    var body: some View {
      StopCardView(userName: "임현규")
        .padding(.sm)
    }
}

#Preview {
    StopCardTestView()
}
