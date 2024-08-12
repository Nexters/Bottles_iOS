//
//  OutlinedStyleButton.swift.swift
//  DesignSystemExample
//
//  Created by JongHoon on 7/27/24.
//

import SwiftUI

public struct OutlinedStyleButton: View {
  private let configurationInfo: ConfigurationInfo
  private let title: String
  private let buttonType: ButtonType
  private let buttonStyle: OutlinedButtonStyle
  /// Toggle Button 구현시 필요
  private let isSelected: Bool?
  private let action: () -> Void
  
  public init(
    _ configurationInfo: ConfigurationInfo,
    title: String,
    buttonType: ButtonType,
    isSelected: Bool? = nil,
    action: @escaping () -> Void
  ) {
    self.configurationInfo = configurationInfo
    self.title = title
    self.buttonType = buttonType
    self.isSelected = isSelected
    self.buttonStyle = OutlinedButtonStyle(
      configurationInfo: configurationInfo,
      isSelected: isSelected
    )
    self.action = action
  }
  
  public var body: some View {
    outlinedStyleButton
      .buttonStyle(buttonStyle)
  }
}

// MARK: - Public Extension

public extension OutlinedStyleButton {
  enum ConfigurationInfo {
    case small(contentType: ContentType)
    case medium(contentType: ContentType)
    case large
    
    public enum ContentType {
      case text
      case image(type: ImageType)
      
      public enum ImageType {
        case remote(url: String)
        case local(bottleImageSystem: Image.BottleImageSystem)
      }
    }
  }
}

// MARK: - Private Views

private extension OutlinedStyleButton {
  var titleText: some View {
    Text(title)
      .font(to: .wantedSans(.body))
  }
  
  @ViewBuilder
  var sizeBasedButtonLabel: some View {
    switch configurationInfo {
    case let .small(contentType):
      switch contentType {
      case .text:
        titleText
        
      case let .image(imageType):
        HStack(spacing: .xs) {
          imageView(imageType: imageType)
            .frame(width: 16.0, height: 16.0)
          
          titleText
        }
      }
      
    case let .medium(contentType):
      switch contentType {
      case .text:
        titleText
        
      case let .image(imageType):
          VStack(spacing: .sm) {
            imageView(imageType: imageType)
              .frame(width: 100, height: 100)
            titleText
          }        
      }
      
    case .large:
      titleText
    }
  }
  
  @ViewBuilder
  var outlinedStyleButton: some View {
    switch buttonType {
    case .normal:
      sizeBasedButtonLabel.asButton(action: action)
      
    case .throttle:
      sizeBasedButtonLabel.asThrottleButton(action: action)
      
    case .debounce:
      sizeBasedButtonLabel.asDebounceButton(action: action)
    }
  }
  
  // TODO: Image 정해지면 corner radius 등 확인 필요
  @ViewBuilder
  func imageView(imageType: ConfigurationInfo.ContentType.ImageType) -> some View {
    var imageViewType: ImageViewType {
      switch imageType {
      case let .remote(url):
        switch configurationInfo {
        case .small:
          return .remote(url: url, downsamplingWidth: 20.0, downsamplingHeight: 20.0)
          
        case .medium:
          return .remote(url: url, downsamplingWidth: 152.0, downsamplingHeight: 152.0)
          
        default:
          assertionFailure("Wrong Image Configuration")
          return .local(bottleImageSystem: .icom(.siren))
        }
            
      case let .local(bottleImageSystem):
        return .local(bottleImageSystem: bottleImageSystem)
      }
    }
    
    BottleImageView(type: imageViewType)
  }
}



#Preview {
  OutlinedStyleButton(
    .small(contentType: .text),
    title: "test",
    buttonType: .normal,
    action: {
      print("teste")
    }
  )
}
