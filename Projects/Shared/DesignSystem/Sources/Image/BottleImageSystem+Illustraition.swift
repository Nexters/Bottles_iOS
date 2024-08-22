//
//  BottleImageSystem+Illustraition.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 8/9/24.
//

import SwiftUI

public extension Image.BottleImageSystem {
  enum Illustraition: Imageable {
    case logo
    case whiteLogo
    case boy
    case girl
    case loginBackground
    case sandBeachBackground
    case telescope
    case bottle1
    case bottle2
    case islandHasBottle
    case islandEmptyBottle
    case yes
    case no
    case loudspeark
    case phone
    case basket
    case splash
    case firstPingPong
    case secondPingPong
    case photoShare
    case bottleArrivalPhone
  }
}

public extension Image.BottleImageSystem.Illustraition {
  var image: Image {
    switch self {
    case .logo:
      return SharedDesignSystemAsset.Images.illustraitionLogo.swiftUIImage
    case .whiteLogo:
      return SharedDesignSystemAsset.Images.illustraitionWhiteLogo.swiftUIImage
    case .boy:
      return SharedDesignSystemAsset.Images.illustraitionBoy.swiftUIImage
    case .girl:
      return SharedDesignSystemAsset.Images.illustraitionGirl.swiftUIImage
    case .loginBackground:
      return SharedDesignSystemAsset.Images.illustraitionLoginBackground.swiftUIImage
    case .sandBeachBackground:
      return SharedDesignSystemAsset.Images.illustrationSandBeachBackground.swiftUIImage
    case .telescope:
      return SharedDesignSystemAsset.Images.illustraitionTelescope.swiftUIImage
    case .bottle1:
      return SharedDesignSystemAsset.Images.illustraitionBottle1.swiftUIImage
    case .bottle2:
      return SharedDesignSystemAsset.Images.illustraitionBottle2.swiftUIImage
    case .islandHasBottle:
      return SharedDesignSystemAsset.Images.illustraitionIslandHasBottle.swiftUIImage
    case .islandEmptyBottle:
      return SharedDesignSystemAsset.Images.illustraitionIslandEmptyBottle.swiftUIImage
    case .yes:
      return SharedDesignSystemAsset.Images.illustraitionYes.swiftUIImage
    case .no:
      return SharedDesignSystemAsset.Images.illustraitionNo.swiftUIImage
    case .loudspeark:
      return SharedDesignSystemAsset.Images.illustraitionLoudspeaker.swiftUIImage
    case .phone:
      return SharedDesignSystemAsset.Images.illustraitionPhone.swiftUIImage
    case .basket:
      return SharedDesignSystemAsset.Images.illustraitionBasket.swiftUIImage
    case .splash:
      return SharedDesignSystemAsset.Images.imageSplash.swiftUIImage
    case .firstPingPong:
      return SharedDesignSystemAsset.Images.illustrationFirstPingPong.swiftUIImage
    case .secondPingPong:
      return SharedDesignSystemAsset.Images.illustrationSecondPingPong.swiftUIImage
    case .photoShare:
      return SharedDesignSystemAsset.Images.illustraitionPhotoShare.swiftUIImage
    case .bottleArrivalPhone:
      return SharedDesignSystemAsset.Images.illustraitionBottleArrivalPhone.swiftUIImage
    }
  }
}
