//
//  ToastGroupView.swift
//  DesignSystemExample
//
//  Created by JongHoon on 8/4/24.
//

import SwiftUI

struct ToastGroup: View {
  @StateObject var toastManager = ToastManager.shared
  var body: some View {
    GeometryReader {
      let size = $0.size
      let safeArea = $0.safeAreaInsets
      
      ZStack {
        ForEach(toastManager.toasts) { toast in
          ToastItemView(size: size, item: toast)
        }
      }
      .padding(.bottom, safeArea.top == .zero ? 16.0 : 12.0)
      .frame(
        maxWidth: .infinity,
        maxHeight: .infinity,
        alignment: .bottom
      )
    }
  }
}
