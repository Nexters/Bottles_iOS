//
//  OutlinedStyleButtonTestView.swift
//  DesignSystemExample
//
//  Created by JongHoon on 7/27/24.
//

import SwiftUI

import SharedDesignSystem

struct OutlinedStyleButtonTestView: View {
  var body: some View {
    ScrollView {
      VStack(spacing: 16.0) {
        OutlinedStyleButtonTestItem(
          title: "Small Text",
          configurationInfo: .small(contentType: .text)
        )
        
        OutlinedStyleButtonTestItem(
          title: "Small Image",
          configurationInfo: .small(contentType: .image(type: .remote(url: "https://static.wikia.nocookie.net/wallaceandgromit/images/3/38/Gromit-3.png/revision/latest/scale-to-width/360?cb=20191228190308")))
        )
        
        OutlinedStyleButtonTestItem(
          title: "Medium Text",
          configurationInfo: .medium(contentType: .text)
        )
        
        OutlinedStyleButtonTestItem(
          title: "Medium Image",
          configurationInfo: .medium(contentType: .image(type: .remote(url: "https://static.wikia.nocookie.net/wallaceandgromit/images/3/38/Gromit-3.png/revision/latest/scale-to-width/360?cb=20191228190308")))
        )
        
        OutlinedStyleButtonTestItem(
          title: "large",
          configurationInfo: .large
        )
      }
    }
  }
}

#Preview {
  OutlinedStyleButtonTestView()
}
