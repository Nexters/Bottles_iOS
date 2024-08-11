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
        ToastSection()
        ListSection()
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
            ImagePickerButton(selectedImage: .constant([]), action: { })
            .asDebounceButton {}
            .padding(.xl)
          ,
          label: { Text("ImagePickerButton") }
        )
        
        NavigationLink(
          "Loading Indicator",
          destination: {
            LoadingIndicator()
          })
      },
      header: {
        Text("ETC")
          .font(.headline)
      }
    )
  }
}

struct CardSection: View {
  
  @State var textFieldState: TextFieldState = .enabled
  @State var text: String = ""
  @State var isSelctedYesButton: Bool = false
  @State var isSelctedNoButton: Bool = false
  
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
        
        NavigationLink(
          destination: LetterCardTestView(),
          label: { Text("LettetCardView") }
        )
        
        
        NavigationLink(
          destination: UserProfileTestView(),
          label: {
            Text("UserProfileView")
          }
        )
        
        NavigationLink(
          destination: StopCardTestView(),
          label: {
            Text("StopCardView")
          }
        )        
//        NavigationLink(
//          destination: 
//            QuestionPingPongTestView(),
//          label: {
//            Text("Question PingPong View")
//          }
//        )
        
//        NavigationLink(
//          destination: 
//            PhotoSharePingPongTestView(),
//          label: {
//            Text("PhotoShare PingPong View")
//          }
//        )
        
//        NavigationLink(
//          destination: 
//            FinalSelectPingPongTestView(),
//          label: {
//            Text("FinalSelectPingPongView")
//          }
//        )
        
        NavigationLink(
          destination: VStack(spacing: 30) {
            HStack(spacing: 0) {
              PingPongBubble(content: "어떤 날은 아침에 눈이 번쩍 떠지는 게 힘이 펄펄 나는 것 같은가 하면 또 어떤 날은 몸이 진흙으로 만들어진 것 같은 때가 있습니다. 몸이 힘들면 마음이 가라앉기 마련입니다. ", isRight: false)
              Spacer()
            }
            HStack(spacing: 0) {
              Spacer()
              PingPongBubble(content: "ㅇㅇ", isRight: true)
            }
          },
          label: {
            Text("PingPongBubble")
          }
        )
      },
      header: {
        Text("Card")
          .font(.headline)
      }
    )
  }
}

struct ToastSection: View {
  var body: some View {
    Section(
      content: {
        NavigationLink(
          destination: ToastTestView(),
          label: { Text("Toast Test") }
        )
      },
      header: {
        Text("Toast")
          .font(.headline)
      }
    )
  }
}

struct ListSection: View {
  var body: some View {
    Section(
      content: {
        NavigationLink(
          destination: BottleStorageList(),
          label: { Text("Bottle Storage List") }
        )
      },
      header: {
        Text("List")
          .font(.headline)
      }
    )
  }
}

#Preview {
  DesignSystemExampleView()
}
