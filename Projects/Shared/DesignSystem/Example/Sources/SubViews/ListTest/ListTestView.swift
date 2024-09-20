//
//  ListTestView.swift
//  DesignSystemExample
//
//  Created by 임현규 on 9/2/24.
//

import SwiftUI

import SharedDesignSystem

struct ListTestView: View {
  @State private var isOn: Bool = false
  private let title = "title"
  private let subTitle = "subTitle"
  private let buttonTitle = "업데이트"
  
  var body: some View {
    VStack(spacing: .md) {
      ArrowListView(title: title)
      
      ArrowListView(title: title, subTitle: subTitle)
      
      ToggleListView(title: title, isOn: $isOn)
      
      ToggleListView(title: title, subTitle: subTitle, isOn: $isOn)
      
      ButtonListView(title: title, buttonTitle: buttonTitle) {
        print("first ButtonListView Button DidTapped")
      }
      
      ButtonListView(title: title, subTitle: subTitle, buttonTitle: buttonTitle) {
        print("second ButtonListView Button DidTapped")
      }
      
      TextListView(title: title)
      
      TextListView(title: title, subTitle: subTitle)
    }
    .padding(.horizontal, .md)
  }
}
