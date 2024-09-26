//
//  TextListView.swift
//  SharedDesignSystem
//
//  Created by 임현규 on 9/20/24.
//

import SwiftUI

public struct TextListView: View {
  public let title: String
  public let subTitle: String?
  
  public init(
    title: String,
    subTitle: String? = nil
  ) {
    self.title = title
    self.subTitle = subTitle
  }
  
  public var body: some View {
    ListContainerView(
      title: title,
      subTitle: subTitle,
      content: EmptyView()
    )
  }
}
