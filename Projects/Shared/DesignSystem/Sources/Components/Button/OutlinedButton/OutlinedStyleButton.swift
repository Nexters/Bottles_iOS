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
        case local(imageName: String)
      }
    }
  }
}

// MARK: - Private Views

private extension OutlinedStyleButton {
  var titleText: some View {
    WantedSansStyleText(
      title,
      style: .body,
      color: .secondary
    )
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
            .background(Color.BottleColorSystem.neutral(.neutral400).color)
          
          titleText
        }
      }
      
    case let .medium(contentType):
      switch contentType {
      case .text:
        titleText
        
      case let .image(imageType):
        GeometryReader { geometry in
          let width = geometry.size.width
          VStack(spacing: .sm) {
            imageView(imageType: imageType)
              .frame(width: width, height: width)
            
            titleText
          }
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
          return .local(imageNmae: "no")
        }
            
      case let .local(imageName):
        return .local(imageNmae: imageName)
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
