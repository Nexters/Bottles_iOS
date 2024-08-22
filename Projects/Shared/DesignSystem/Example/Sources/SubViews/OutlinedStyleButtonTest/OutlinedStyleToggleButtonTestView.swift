//
//  OutlinedStyleToggleButtonTestView.swift
//  SharedDesignSystem
//
//  Created by JongHoon on 7/28/24.
//

import SwiftUI

import SharedDesignSystem

struct OutlinedStyleToggleButtonTestView: View {
  @State private var smallTextButtonIsSelected = false
  @State private var smallImageButtonIsSelected = false
  @State private var mediumTextButtonIsSelected = false
  @State private var mediumImageButtonIsSelected = false
  @State private var largeButtonIsSelected = false
  
  var body: some View {
    ScrollView {
      VStack(spacing: 16.0) {
        OutlinedStyleButtonTestItem(
          title: "Small Text",
          configurationInfo: .small(contentType: .text),
          isSelected: $smallTextButtonIsSelected,
          action: {
            smallTextButtonIsSelected.toggle()
          }
        )
        
        OutlinedStyleButtonTestItem(
          title: "Small Image",
          configurationInfo: .small(contentType: .image(type: .remote(url: "https://static.wikia.nocookie.net/wallaceandgromit/images/3/38/Gromit-3.png/revision/latest/scale-to-width/360?cb=20191228190308"))),
          isSelected: $smallImageButtonIsSelected,
          action: {
            smallImageButtonIsSelected.toggle()
          }
        )
        
        OutlinedStyleButtonTestItem(
          title: "Medium Text",
          configurationInfo: .medium(contentType: .text),
          isSelected: $mediumTextButtonIsSelected,
          action: {
            mediumTextButtonIsSelected.toggle()
          }
        )
        
        OutlinedStyleButtonTestItem(
          title: "Medium Image",
          configurationInfo: .medium(contentType: .image(type: .remote(url: "https://static.wikia.nocookie.net/wallaceandgromit/images/3/38/Gromit-3.png/revision/latest/scale-to-width/360?cb=20191228190308"))),
          isSelected: $mediumImageButtonIsSelected,
          action: {
            mediumImageButtonIsSelected.toggle()
          }
        )
        
        OutlinedStyleButtonTestItem(
          title: "large",
          configurationInfo: .large,
          isSelected: $largeButtonIsSelected,
          action: {
            largeButtonIsSelected.toggle()
          }
        )
      }
    }
  }
}
