//
//  ReportUserFeatureInterface.swift
//  FeatureReportInterface
//
//  Created by 임현규 on 8/12/24.
//

import Foundation

import SharedDesignSystem

import ComposableArchitecture

@Reducer
public struct ReportUserFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  // Desination
  @Reducer(state: .equatable)
  public enum Destination {
    case alert(AlertState<ReportUserFeature.Action.Alert>)
  }
  
  // State
  @ObservableState
  public struct State: Equatable {
    public var reportText: String
    public var userProfile: UserReportProfile
    public var textFieldState: TextFieldState
    public var isDisableDoneButton: Bool

    @Presents var destination: Destination.State?

    public init(
      reportText: String = "",
      userProfile: UserReportProfile,
      textFieldState: TextFieldState = .enabled,
      isDisableDoneButton: Bool = true
    ) {
      self.reportText = reportText
      self.userProfile = userProfile
      self.textFieldState = textFieldState
      self.isDisableDoneButton = isDisableDoneButton
    }
  }
  
  // Action
  public enum Action: BindableAction {
    // View Life Cycle
    case onAppear
    
    // User Action
    case texFieldDidFocused(isFocused: Bool)
    case onTapGesture
    case backButtonDidTapped
    case doneButtonDidTapped
    
    // Delegate
    case delegate(Delegate)
    public enum Delegate {
      case reportDidCompleted
      case backButtonDidTapped
    }
    
    // Alert
    case alert(Alert)
    public enum Alert: Equatable {
      case confirmReport
      case dismiss
    }
    
    // ETC
    case destination(PresentationAction<Destination.Action>)
    case binding(BindingAction<State>)
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    reducer
      .ifLet(\.$destination, action: \.destination)
  }
}
