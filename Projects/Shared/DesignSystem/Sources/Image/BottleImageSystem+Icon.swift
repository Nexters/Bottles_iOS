//
//  BottleImageSystem+Icon.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 8/3/24.
//

import SwiftUI

public extension Image.BottleImageSystem {
  enum Icon: Imageable {
    case leftArrow
    case down
    case right
    case up
    case delete
    case clearDelete
    case share
    case siren
    case plus
    case verticalLine
    case kakaoLogo
    case sandBeach
    case bottleStorage
    case myPage
    case appleLogo
    case warning
  }
}

public extension Image.BottleImageSystem.Icon {
  var image: Image {
    switch self {
    case .leftArrow:
      return SharedDesignSystemAsset.Images.iconArrowLeft.swiftUIImage
    case .down:
      return SharedDesignSystemAsset.Images.iconDown.swiftUIImage
    case .right:
      return SharedDesignSystemAsset.Images.iconRight.swiftUIImage
    case .up:
      return SharedDesignSystemAsset.Images.iconUp.swiftUIImage
    case .delete:
      return SharedDesignSystemAsset.Images.iconDelete.swiftUIImage
    case .clearDelete:
      return SharedDesignSystemAsset.Images.iconClearDelete.swiftUIImage
    case .share:
      return SharedDesignSystemAsset.Images.iconShare.swiftUIImage
    case .siren:
      return SharedDesignSystemAsset.Images.iconSiren.swiftUIImage
    case .plus:
      return SharedDesignSystemAsset.Images.iconPlus.swiftUIImage
    case .verticalLine:
      return SharedDesignSystemAsset.Images.iconVerticalLine.swiftUIImage
      
    case .kakaoLogo:
      return SharedDesignSystemAsset.Images.iconKakaoLogo.swiftUIImage
      
    case .sandBeach:
      return SharedDesignSystemAsset.Images.iconSandBeach.swiftUIImage
      
    case .bottleStorage:
      return SharedDesignSystemAsset.Images.iconBottleStorage.swiftUIImage
      
    case .myPage:
      return SharedDesignSystemAsset.Images.iconMyPage.swiftUIImage
      
    case .appleLogo:
      return SharedDesignSystemAsset.Images.iconAppleLogo.swiftUIImage
      
    case .warning:
      return SharedDesignSystemAsset.Images.iconWarning.swiftUIImage
    }
  }
}





