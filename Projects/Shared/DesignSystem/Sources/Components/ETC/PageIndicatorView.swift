//
//  PageIndicatorView.swift
//  DesignSystemExample
//
//  Created by 임현규 on 8/3/24.
//

import SwiftUI

public struct PageIndicatorView: View {
  private var pageInfo: PageInfo
  
  public init(pageInfo: PageInfo) {
    self.pageInfo = pageInfo
  }
  
  public var body: some View {
    HStack(spacing: .xxs) {
      WantedSansStyleText(
        "\(pageInfo.nowPage)",
        style: .subTitle2,
        color: .quinary
      )
      .padding(.leading, .xs)
      
      WantedSansStyleText(
        "/",
        style: .subTitle2,
        color: .senary
      )
      
      WantedSansStyleText(
        "\(pageInfo.totalCount)",
        style: .subTitle2,
        color: .senary
      )
      .padding(.trailing, .xs)
    }
    .frame(height: 26)
    .background {
      RoundedRectangle(cornerRadius: BottleRadiusType.xs.value)
        .fill(ColorToken.container(.secondary).color)
    }
  }
}
