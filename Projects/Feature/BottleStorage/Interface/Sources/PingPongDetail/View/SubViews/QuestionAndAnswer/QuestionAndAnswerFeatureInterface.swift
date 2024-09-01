//
//  QuestionAndAnswerFeatureInterface.swift
//  FeatureBottleStorage
//
//  Created by JongHoon on 8/11/24.
//

import Foundation

import DomainBottleInterface
import SharedDesignSystem

import ComposableArchitecture

@Reducer
public struct QuestionAndAnswerFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    let bottleID: Int
    private var pingPong: BottlePingPong?
    var photoInfo: Photo? {
      pingPong?.photo
    }
    var isStopped: Bool {
      return pingPong?.isStopped == true
    }
    
    var isShowLoadingIndicator: Bool
      
    // first letter
    var firstLetter: Letter? {
      return pingPong?.letters.first(where: { $0.order == 1 })
    }
    var isFirstLetterActive: Bool {
      guard let firstLetter
      else {
        return false
      }
      return firstLetter.canshow == true
    }
    var firstLetterQuestionState: QuestionStateType {
      letterQuestionState(firstLetter)
    }
    var firstLetterTextFieldContent: String
    
    // second letter
    var secondLetter: Letter? {
      return pingPong?.letters.first(where: { $0.order == 2 })
    }
    var isSecondLetterActive: Bool {
      guard let secondLetter
      else {
        return false
      }
      return secondLetter.canshow == true
    }
    var secondLetterQuestionState: QuestionStateType {
      letterQuestionState(secondLetter)
    }
    var secondLetterTextFieldContent: String
    
    // third letter
    var thirdLetter: Letter? {
      return pingPong?.letters.first(where: { $0.order == 3 })
    }
    var isThirdLetterActive: Bool {
      guard let thirdLetter
      else {
        return false
      }
      return thirdLetter.canshow == true
    }
    var thirdLetterQuestionState: QuestionStateType {
      letterQuestionState(thirdLetter)
    }
    var thirdLetterTextFieldContent: String
    
    var textFieldState: TextFieldState
    
    // 사진 선택
    var photoShareIsActive: Bool {
      guard let photoStatus = pingPong?.photo.photoStatus
      else {
        return false
      }
      
      return photoStatus != PingPongPhotoStatus.disabled
    }
    
    var photoShareStateType: PingPongPhotoStatus {
      return photoInfo?.photoStatus ?? .disabled
    }

    var photoIsSelctedYesButton: Bool
    var photoIsSelctedNoButton: Bool
    
    // 최종 선택
    var finalSelectIsActive: Bool {
      guard let matchStatus = pingPong?.matchResult.matchStatus
      else {
        return false
      }
      
      return matchStatus != .disabled
    }
    var pingPongMatchStatus: PingPongMatchStatus {
      return pingPong?.matchResult.matchStatus ?? .disabled
    }
    var finalSelectIsSelctedYesButton: Bool
    var finalSelectIsSelctedNoButton: Bool
    
    @Presents var destination: Destination.State?
    
    public init(bottleID: Int) {
      self.bottleID = bottleID
      self.isShowLoadingIndicator = false
      self.firstLetterTextFieldContent = ""
      self.secondLetterTextFieldContent = ""
      self.thirdLetterTextFieldContent = ""
      self.textFieldState = .enabled
      self.photoIsSelctedYesButton = false
      self.photoIsSelctedNoButton = false
      self.finalSelectIsSelctedYesButton = false
      self.finalSelectIsSelctedNoButton = false
    }
    
    mutating func configurePingPong(_ pingPong: BottlePingPong) {
      self.pingPong = pingPong
    }
    
    func letterQuestionState(_ letter: Letter?) -> QuestionStateType {
      guard let letter
      else {
        return .none
      }
      
      let mySelf = letter.myAnswer ?? "(작성한 내용이 없습니다.)"
      let peer = letter.otherAnswer ?? "(작성한 내용이 없습니다.)"
      
      switch (letter.myAnswer == nil, letter.otherAnswer == nil) {
      case (true, false):
        return .peerAnswered(peer: peer)
        
      case (true, true):
        return .noAnswer
        
      case (false, true):
        return .selfAnswered(mySelf: mySelf)
        
      case (false, false):
        return .bothAnswered(
          peer: peer,
          mySelf: mySelf
        )
      }
    }
  }
  
  public enum Action: BindableAction {
    // View Life Cycle
    case onAppear
    
    case pingPongDidFetched(BottlePingPong)
    case texFieldDidFocused(isFocused: Bool)
    case letterDoneButtonDidTapped(
      order: Int,
      answer: String
    )
    case sharePhotoSelectButtonDidTapped(willShare: Bool)
    case finalSelectButtonDidTapped(willMatch: Bool)
    case refreshPingPongDidRequired
    case configureShowLoadingIndicatorRequired(isShow: Bool)
    case stopTalkButtonDidTapped
    case refreshDidPulled
    
    // ETC.
    case binding(BindingAction<State>)
    case destination(PresentationAction<Destination.Action>)
    
    case alert(Alert)
    public enum Alert: Equatable {
      case confirmStopTalk
    }
    
    case delegate(Delegate)
    
    public enum Delegate {
      case reloadPingPongRequired
      case popToRootDidRequired
      case refreshPingPong
    }
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    reducer
      .ifLet(\.$destination, action: \.destination)
  }
}

// MARK: - Destination

extension QuestionAndAnswerFeature {
  @Reducer(state: .equatable)
  public enum Destination {
    case alert(AlertState<QuestionAndAnswerFeature.Action.Alert>)
  }
}
