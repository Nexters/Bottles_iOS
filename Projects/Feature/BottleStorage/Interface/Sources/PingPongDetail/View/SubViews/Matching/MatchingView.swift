//
//  MatchingView.swift
//  FeatureBottleStorage
//
//  Created by JongHoon on 8/11/24.
//

import SwiftUI
import UniformTypeIdentifiers

import SharedDesignSystem
import ComposableArchitecture

public struct MatchingView: View {
  @Perception.Bindable private var store: StoreOf<MatchingFeature>
  @Environment(\.openURL) var openURL
  
  public init(store: StoreOf<MatchingFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      ScrollView {
        VStack(alignment: .leading, spacing: 0.0) {
          title
            .padding(.vertical, 32)
          
          matchingInfo
          
          if store.matchingState == .success,
             let placeName = store.matchingPlace,
             let placeImageURL = store.matchingPlaceImageURL {
            Spacer().frame(height: 12.0)
            placeRecommendView(
              placeName: placeName,
              placeImageURL: placeImageURL
            )
          }
          
          Spacer()
          
          bottomButton
          
          Spacer()
            .frame(height: 30)
        }
        .padding(.horizontal, .md)
        .frame(maxHeight: .infinity)
        .background(to: ColorToken.background(.primary))
      }
      .background(to: ColorToken.background(.primary))
      .scrollIndicators(.hidden)
    }
  }
}

// MARK: - Views

private extension MatchingView {
  @ViewBuilder
  var title: some View {
    switch store.matchingState {
    case .waiting:
      TitleView(
        title: "\(store.peerUserName ?? "")님의\n결정을 기다리고 있어요",
        caption: "조금만 더 기다려주세요!"
      )
    case .success:
      TitleView(
        title: "축하해요! 지금부터 찐-하게\n서로를 알아가 보세요",
        caption: "아이디를 복사해 더 깊은 대화를 나눠보세요"
      )
    case .failure:
      TitleView(
        title: "다른 보틀을\n열어보는 건 어때요",
        caption: "아쉽지만 매칭에 실패했어요"
      )
    default:
      EmptyView()
    }
  }
  
  @ViewBuilder
  var matchingInfo: some View {
    switch store.matchingState {
    case .waiting:
      GeometryReader { geometryProxy in
        WithPerceptionTracking {
          let width = geometryProxy.size.width - 50
          HStack(spacing: 0 ) {
            Spacer()
            BottleImageView(
              type: .local(
                bottleImageSystem: .illustraition(.phone)
              )
            )
            .frame(width: width, height: width)
            Spacer()
          }
        }
      }
      .aspectRatio(1, contentMode: .fit)
      
    case .success:
      kakaoTalkIdShareView
      
    case .failure:
      GeometryReader { geometryProxy in
        WithPerceptionTracking {
          let width = geometryProxy.size.width - 50
          HStack(spacing: 0 ) {
            Spacer()
            BottleImageView(
              type: .local(
                bottleImageSystem: .illustraition(.bottle1)
              )
            )
            .frame(width: width, height: width)
            Spacer()
          }
        }
      }
      .aspectRatio(1, contentMode: .fit)
      
    default:
      EmptyView()
    }
  }
  
  var kakaoTalkIdShareView: some View {
    VStack(spacing: .xl) {
      WantedSansStyleText(
        "카카오톡 아이디",
        style: .body,
        color: .quinary
      )
      .padding(.vertical, 2)
      .padding(.horizontal, .xs)
      .background {
        RoundedRectangle(cornerRadius: BottleRadiusType.xs.value)
          .fill(ColorToken.container(.secondary).color)
      }
      
      WantedSansStyleText(
        store.kakaoTalkId ?? "hello",
        style: .subTitle1,
        color: .primary
      )
      
      OutlinedStyleButton(
        .small(contentType: .image(type: .local(bottleImageSystem: .icom(.share)))),
        title: "복사하기",
        buttonType: .throttle
      ) {
        let clipboard = UIPasteboard.general
        clipboard.setValue(store.kakaoTalkId ?? "", forPasteboardType: UTType.plainText.identifier)
        store.send(.copyButtonDidTapped)
      }
    }
    .padding(.horizontal, .md)
    .padding(.vertical, .xl)
    .frame(maxWidth: .infinity)
    .overlay(
      RoundedRectangle(cornerRadius: BottleRadiusType.xl.value)
        .strokeBorder(
          ColorToken.border(.primary).color,
          lineWidth: 1.0
        )
    )
  }
  
  @ViewBuilder
  var bottomButton: some View {
    switch store.matchingState {
    case .waiting:
      EmptyView()
    case .success:
      SolidButton(
        title: "카카오톡 바로가기",
        sizeType: .large,
        buttonType: .throttle,
        action: { openKakaoTalk() }
      )
    
    case .failure:
      SolidButton(
        title: "다른 보틀 열어보기",
        sizeType: .large,
        buttonType: .throttle,
        action: { store.send(.otherBottleButtonDidTapped) }
      )
    default:
      EmptyView()
    }
  }
  
  func placeRecommendView(placeName: String, placeImageURL: String) -> some View {
    VStack(alignment: .leading, spacing: .xl) {
      VStack(spacing: .xs) {
        VStack(alignment: .leading, spacing: 0.0) {
          WantedSansStyleText(
            "두근두근 첫만남, 이런장소는 어때요?",
            style: .subTitle1,
            color: .primary
          )
          
          WantedSansStyleText(
            "보틀 AI가 취향에 맞는 장소를 추천 드려요!",
            style: .subTitle1,
            color: .tertiary
          )
        }
        
        HStack(spacing: 0.0) {
          Spacer()
          WantedSansStyleText(
            placeName,
            style: .subTitle1,
            color: .primary
          )
          Spacer()
        }
        
        HStack(spacing: 0.0) {
          Spacer()
          
          BottleImageView(type: .remote(
            url: placeImageURL,
            downsamplingWidth: 300.0,
            downsamplingHeight: 300.0
          ))
          .frame(width: 200.0, height: 200.0)
          .clipShape(RoundedRectangle(cornerRadius: BottleRadiusType.md.value))
          
          Spacer()
        }
      }
    }
    .padding(.horizontal, .md)
    .padding(.vertical, .xl)
    .overlay(
      RoundedRectangle(cornerRadius: BottleRadiusType.xl.value)
        .strokeBorder(
          ColorToken.border(.primary).color,
          lineWidth: 1.0
        )
    )
    .padding(.bottom, 32.0)
  }
}

private extension MatchingView {
  // TODO: 추후 구조 변경 필요
  func openKakaoTalk() {
    let kakaoTalk = "kakaotalk://"
    guard let kakaoTalkURL = NSURL(string: kakaoTalk) as? URL else { return }
    openURL(kakaoTalkURL)
  }
}
