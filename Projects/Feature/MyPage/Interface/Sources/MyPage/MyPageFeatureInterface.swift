//
//  MyPageFeatureInterface.swift
//  FeatureMyPageInterface
//
//  Created by JongHoon on 7/24/24.
//

import Foundation

import DomainProfileInterface

import FeatureTabBarInterface

import SharedDesignSystem

import ComposableArchitecture

@Reducer
public struct MyPageFeature {
  private let reducer: Reduce<State, Action>
  
  public init(reducer: Reduce<State, Action>) {
    self.reducer = reducer
  }
  
  @ObservableState
  public struct State: Equatable {
    var isShowLoadingProgressView: Bool
    
    public var keywordItem: [ClipItem]
    public var userInfo: UserInfo
    public var introduction: Introduction
    public var blockedContactsCount: Int
    public var currentAppVersion: String?
    public var isShowApplicationUpdateButton: Bool
    public var isPresentTerms: Bool
    public var temrsURL: String?
    
    @Presents var destination: Destination.State?
    
    public init(
      keywordItem: [ClipItem] = []
    ) {
      self.isShowLoadingProgressView = true
      self.keywordItem = keywordItem
      self.userInfo = .init(userAge: -1, userImageURL: "", userName: "")
      self.introduction = .init(answer: "", question: "")
      self.blockedContactsCount = 0
      self.isShowApplicationUpdateButton = false
      self.isPresentTerms = false
    }
  }
  
  public enum Action: BindableAction {
    // View Life Cycle
    case onLoad
    case onAppear
    
    case userProfileDidFetched(UserProfile)
    case userProfileUpdateDidRequest
    case updatePhoneNumberForBlockButtonDidTapped
    case logOutButtonDidTapped
    case logOutDidCompleted
    case withdrawalButtonDidTapped
    case withdrawalDidCompleted
    case selectedTabDidChanged(TabType)
    case profileEditListDidTapped
    case alertSettingListDidTapped
    case accountSettingListDidTapped
    case updateApplicationButtonTapped
    
    case updatePhoneNumberForBlockCompleted(count: Int)
    case contactsAccessDeniedErrorOccurred
    case applicationVersionInfoFetched(currentAppVersion: String, isNeedUpdate: Bool)
    case termsOfServiceListDidTapped
    case privacyPolicyListDidTapped
    case termsWebViewDidDismiss
    case contactListDidTapped
    case contactsDidReceived(contacts: [String])
    case configureLoadingProgressView(isShow: Bool)
    
    case configureLoadingProgressView(isShow: Bool)
    
    case delegate(Delegate)
    
    public enum Delegate {
      case withdrawalButtonDidTapped
      case withdrawalDidCompleted
      case logoutDidCompleted
      case selectedTabDidChanged(TabType)
      case profileEditListDidTapped
      case alertSettingListDidTapped
      case accountSettingListDidTapped
    }
      
    case alert(Alert)
    public enum Alert: Equatable {
      case confirmLogOut
      case confirmWithdrawal
      case confirmBlockContacts(contacts: [String])
      case dismissAlert
      case dismissContactsAlert
    }
  
    // ETC
    case destination(PresentationAction<Destination.Action>)
    case binding(BindingAction<State>)
  }
  
  public var body: some ReducerOf<Self> {
    reducer
      .ifLet(\.$destination, action: \.destination)
  }
}

extension MyPageFeature {
  @Reducer(state: .equatable)
  public enum Destination {
    case alert(AlertState<MyPageFeature.Action.Alert>)
  }
}
