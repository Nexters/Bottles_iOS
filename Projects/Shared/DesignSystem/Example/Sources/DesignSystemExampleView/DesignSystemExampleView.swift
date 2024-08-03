//
//  DesignSystemExampleView.swift
//  DesignSystemExample
//
//  Created by JongHoon on 7/27/24.
//

import SwiftUI

import SharedDesignSystem

struct DesignSystemExampleView: View {
  var body: some View {
    NavigationStack {
      List {
        CustomTextViewSection()
        ButtonSection()
        PopupSection()
        LinesTextFieldSection()
        CardSection()
        EtcSection()
      }
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("Design System Example View")
    }
  }
}

struct CustomTextViewSection: View {
  var body: some View {
    Section(
      content: {
        NavigationLink(
          destination: WantedSansStyleTextTestView(),
          label: { Text("Wanted Sans Text Test View") }
        )
        NavigationLink(
          destination: RobotoStyleTextTestView(),
          label: { Text("Roboto Text Test View") }
        )
        NavigationLink(
          destination: LaundaryGothicsStyleTextTestView(),
          label: { Text("Laundary Gothic Text Test View") }
        )
      },
      header: {
        Text("Custom Text View")
          .font(.headline)
      }
    )
  }
}

struct ButtonSection: View {
  var body: some View {
    Section(
      content: {
        NavigationLink(
          destination: OutlinedStyleButtonTestView(),
          label: { Text("Outlined Style Button") }
        )
        NavigationLink(
          destination: OutlinedStyleToggleButtonTestView(),
          label: { Text("Outlined Style Toggle Button") }
        )
        NavigationLink(
          destination: SolidButtonTestView(),
          label: { Text("SolidButton Test View") }
        )
      },
      header: {
        Text("Button")
          .font(.headline)
      }
    )
  }
}

struct PopupSection: View {
  var body: some View {
    Section(
      content: {
        NavigationLink(
          destination: PopupView(
            popupType: .text(
              content: "1시간 후 새로운 보틀이 도착해요"
            )
          ),
          label: {
            Text("Text Popup View")
          }
        )
        
        NavigationLink(
          destination: PopupView(
            popupType: .button(
              content: "자기소개 작성 후 열어볼 수 있어요",
              buttonTitle: "자기소개 작성하기"
            )
          ),
          label: {
            Text("Button Popup View")
          }
        )
      },
      header: {
        Text("Popup")
          .font(.headline)
      }
    )
  }
}

struct LinesTextFieldSection: View {
  var body: some View {
    Section(
      content: {
        NavigationLink(
          destination:
            IntroductionTextFieldTestView(),
          label: { Text("Introduction TextField") }
        )
        NavigationLink(
          destination:
            LetterTextFieldTestView(),
          label: { Text("Letter TextField") }
        )
      },
      header: {
        Text("Lines TextField")
          .font(.headline)
      }
    )
  }
}

struct EtcSection: View {
  var body: some View {
    Section(
      content: {
        NavigationLink(
          destination:
            PageIndicatorTestView(),
          label: { Text("PageIndicator") }
        )
        
        NavigationLink(
          destination:
            VStack(spacing: .xl) {
              
              TitleView(title: "TitleTitleTitleTitleTitle")
              .frame(maxWidth: .infinity)
              .border(.red)
              
              
              TitleView(title: "TitleTitleTitleTitleTitle", caption: "CaptionCaptionCaptionCaption")
              .frame(maxWidth: .infinity)
              .border(.red)
              
              
              TitleView(pageInfo: PageInfo(nowPage: 1, totalCount: 2), title: "TitleTitleTitleTitleTitle", caption: "CaptionCaptionCaptionCaption")
              .frame(maxWidth: .infinity)
              .border(.red)
              
              
              TitleView(pageInfo: PageInfo(nowPage: 1, totalCount: 2), title: "TitleTitleTitleTitleTitle")
              .frame(maxWidth: .infinity)
              .border(.red)
            }
          ,
          label: { Text("TitleView With Only Title") }
        )
        
        NavigationLink(
          destination:
            ImagePickerButton()
            .asDebounceButton {}
            .padding(.xl)
          ,
          label: { Text("ImagePickerButton") }
        )
      },
      header: {
        Text("ETC")
          .font(.headline)
      }
    )
  }
}

struct CardSection: View {
  var body: some View {
    Section(
      content: {
        NavigationLink(
          destination:
            ClipListContainerViewTest(),
          label: { Text("ClipListContainerView") }
        )
        
        NavigationLink(
          destination:
            ClipListViewTest(),
          label: { Text("ClipListView") }
        )
      },
      header: {
        Text("Card")
          .font(.headline)
      }
    )
  }
}

#Preview {
  DesignSystemExampleView()
}
