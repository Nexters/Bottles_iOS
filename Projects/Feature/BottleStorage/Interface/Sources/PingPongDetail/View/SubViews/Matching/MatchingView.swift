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
  
  public init(store: StoreOf<MatchingFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithPerceptionTracking {
      ScrollView {
        VStack(alignment: .leading, spacing: 0.0) {
          title
            .padding(.vertical, 32)
          
          GeometryReader { geo in
            WithPerceptionTracking {
              let width = geo.size.width - 50
              HStack(spacing: 0 ) {
                Spacer()
                matchingInfo
                  .frame(width: width, height: width)
                Spacer()
              }
            }
          }
          .aspectRatio(1, contentMode: .fit)
          
          Spacer()
          bottomButton
          
          Spacer()
            .frame(height: 30)
        }
        .padding(.horizontal, .md)
        .frame(maxHeight: .infinity)
        .background(to: ColorToken.background(.primary))
      }
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
      BottleImageView(
        type: .local(
          bottleImageSystem: .illustraition(.phone)
        )
      )
    case .success:
      kakaoTalkIdShareView
    case .failure:
      BottleImageView(
        type: .local(
          bottleImageSystem: .illustraition(.bottle1)
        )
      )
    default:
      EmptyView()
    }
  }
  
  var kakaoTalkIdShareView: some View {
    RoundedRectangle(cornerRadius: BottleRadiusType.xl.value)
      .strokeBorder(ColorToken.border(.primary).color, lineWidth: 1)
      .frame(maxWidth: .infinity)
      .frame(height: 179)
      .overlay {
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
      }
  }
  
  @ViewBuilder
  var bottomButton: some View {
    switch store.matchingState {
    case .waiting:
      EmptyView()
    case .success:
      EmptyView()
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
}
