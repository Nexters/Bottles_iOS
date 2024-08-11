//
//  NavigationBarModifier.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 8/11/24.
//

import Foundation
import SwiftUI

public extension View {
  func setNavigationBarWithBackButton(backButtonAction: @escaping () -> Void) -> some View {
    self.navigationBarBackButtonHidden(true)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          BottleImageView(type: .local(bottleImageSystem: .icom(.leftArrow)))
            .asThrottleButton(
              action: backButtonAction
            )
            .foregroundStyle(to: ColorToken.icon(.primary))
        }
      }
  }
    
  func setNavigationBarWithBackButtonAndReport(backButtonAction: @escaping () -> Void, reportButtonAction: @escaping () -> Void) -> some View {
    self.navigationBarBackButtonHidden(true)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          BottleImageView(type: .local(bottleImageSystem: .icom(.leftArrow)))
            .asThrottleButton(
              action: backButtonAction
            )
            .foregroundStyle(to: ColorToken.icon(.primary))
        }
        
        ToolbarItem(placement: .topBarTrailing) {
          BottleImageView(type: .local(bottleImageSystem: .icom(.siren)))
            .asThrottleButton(
              action: reportButtonAction
            )
            .foregroundStyle(to: ColorToken.icon(.primary))
        }
      }
    }
}
