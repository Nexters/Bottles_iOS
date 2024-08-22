//
//  ProfileImageUploadView.swift
//  FeatureProfileSetupInterface
//
//  Created by 임현규 on 8/5/24.
//

import SwiftUI
import PhotosUI

import SharedDesignSystem

import ComposableArchitecture

public struct ProfileImageUploadView: View {
  @State private var selectedItems: [PhotosPickerItem] = []
  @State private var selectedImage: [UIImage] = []
  
  private var store: StoreOf<ProfileImageUploadFeature>
  
  public init(store: StoreOf<ProfileImageUploadFeature>) {
    self.store = store
  }
  
  public var body: some View {
    ScrollView {
      VStack(spacing: 0.0) {
        titleView
        
        PhotosPicker(
          selection: $selectedItems,
          maxSelectionCount: 1,
          matching: .images
        ) {
          imagePickerButton
            .frame(height: UIScreen.main.bounds.width - 16.0 * 2)
            .padding(.bottom, .md)
        }
        .onChange(of: selectedItems) { item in
          handleSelectedPhotos(item)
        }
        
        doneButton
      }
      .padding(.bottom, .xl)
    }
    .padding(.horizontal, .md)
    .setNavigationBar {
      makeNaivgationleftButton {
        store.send(.backButtonDidTapped)
      }
    }
    .scrollIndicators(.hidden)
    .toolbar(.hidden, for: .bottomBar)
  }
}

private extension ProfileImageUploadView {
  var titleView: some View {
    TitleView(
      pageInfo: PageInfo(nowPage: 2, totalCount: 2),
      title: "보틀에 담을 나의\n사진을 골라주세요",
      caption: "가치관 문답을 마친 후 동의 하에 공개돼요"
    )
    .padding(.top, .xl)
    .padding(.bottom, 32)
  }
  
  var imagePickerButton: some View {
    ImagePickerButton(
      selectedImage: $selectedImage,
      action: { store.send(.imageDeleteButtonDidTapped) }
    )
  }
  
  var doneButton: some View {
    SolidButton(
      title: "완료",
      sizeType: .full,
      buttonType: .throttle,
      action: { store.send(.doneButtonDidTapped) }
    )
    .disabled(store.isDisableDoneButton)
  }
}

private extension ProfileImageUploadView {
  func handleSelectedPhotos(_ newPhotos: [PhotosPickerItem]) {
    for newPhoto in newPhotos {
      newPhoto.loadTransferable(type: Data.self) { result in
        switch result {
        case .success(let data):
          if let data = data, let newImage = UIImage(data: data) {
            DispatchQueue.main.async {
              selectedImage = [newImage]
              let compressData = newImage.compressImageData()
              store.send(.imageDidSelected(selectedImageData: compressData ?? .init()))
            }
          }
          
          // TODO: 이미지 로드 실패 처리
        case .failure(_):
          return
        }
      }
    }
    
    selectedItems.removeAll()
  }
}

