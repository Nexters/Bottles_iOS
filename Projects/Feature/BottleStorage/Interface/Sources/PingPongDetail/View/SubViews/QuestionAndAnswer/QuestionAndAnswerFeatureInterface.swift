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
    
    public init(bottleID: Int) {
      self.bottleID = bottleID
      self.isShowLoadingIndicator = false
      self.firstLetterTextFieldContent = ""
      self.secondLetterTextFieldContent = ""
      self.thirdLetterTextFieldContent = ""
      self.textFieldState = .enabled
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
    case registerLetterAnswerDidCompleted
    case configureShowLoadingIndicatorRequired(isShow: Bool)
    
    // ETC.
    case binding(BindingAction<State>)
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    reducer
  }
}
