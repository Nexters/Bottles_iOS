//
//  SandBeachCoachMarkView.swift
//  FeatureSandBeachInterface
//
//  Created by 임현규 on 10/28/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct SandBeachCoachMarkView: View {
  @Perception.Bindable private var store: StoreOf<SandBeachCoachMarkFeature>
  
  public init(store: StoreOf<SandBeachCoachMarkFeature>) {
    self.store = store
  }
  
  public var body: some View {
    ZStack {
      Color.black.opacity(0.6)
        .edgesIgnoringSafeArea(.all)
      if store.count == 0 {
        firstCoachMark
      } else if store.count == 1 {
        secondCoachMark
      } else {
        thirdCoachMark
      }
    }
    .compositingGroup()
    .asButton {
      store.send(.coachMarkDidTapped)
    }
  }
}

private extension SandBeachCoachMarkView {
  var firstCoachMark: some View {
    VStack(spacing: 0) {
      Spacer()
        .frame(height: 96)
      
      PopupView(popupType: .coachMark(content: "나의 첫인상이 될\n자기소개를 작성해주세요"))
      
      RoundedRectangle(cornerRadius: 20)
        .frame(width: 267, height: 106)
        .foregroundColor(.white)
        .blendMode(.destinationOut)
        .padding(.top, .xl)
      
      Spacer()
    }
  }
  
  var secondCoachMark: some View {
    VStack(spacing: 0.0) {
      Spacer()
        .frame(height: 239)
      
      PopupView(popupType: .coachMark(content: "바구니를 클릭하면\n보틀 속 자기소개를 읽어볼 수 있어요"))

      GeometryReader { geo in
        HStack(spacing: 0.0) {
          Spacer()
          RoundedRectangle(cornerRadius: 20)
            .frame(width: geo.size.width - 200, height: geo.size.width - 200)
            .foregroundColor(.white)
            .blendMode(.destinationOut)
            .padding(.top, .xl)
          Spacer()
        }
      }
      Spacer()
    }
  }
  
  var thirdCoachMark: some View {
    GeometryReader { geo in
      
      VStack(spacing: 0.0) {
        Spacer()
        
        PopupView(popupType: .coachMark(content: "가치관 문답을 시작한 경우\n문답에서 확인할 수 있어요"))
          .offset(x: geo.size.width * 0.09)

        HStack(spacing: 0.0) {
          Spacer()
          RoundedRectangle(cornerRadius: 20)
            .frame(width: 72, height: 72)
            .foregroundColor(.white)
            .blendMode(.destinationOut)
            .padding(.top, .xl)
            .offset(x: geo.size.width * 0.09)
          Spacer()
          
        }
      }
      .offset(y: -34)
    }
    .ignoresSafeArea(.all, edges: .bottom)
  }
}
