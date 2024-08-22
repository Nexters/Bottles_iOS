import SwiftUI

import FeatureReportInterface

import ComposableArchitecture

@main
struct AppView: App {
  let store = Store(
    initialState: ReportUserFeature.State(
      userProfile: .init(imageURL: "", userID: "", userName: "", userAge: 2)
    ),
    reducer: { ReportUserFeature() }
  )
  var body: some Scene {
    WindowGroup {
      ReportUserView(store: store)
    }
  }
}

