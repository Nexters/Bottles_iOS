import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Shared.name+ModulePath.Shared.ThirdPartyLib.rawValue,
    targets: [    
        .shared(
            implements: .ThirdPartyLib,
            factory: .init(
                dependencies: [
                    .SPM.ComposableArchitecture,
                    .SPM.Moya,
                    .SPM.KakaoSDKAuth,
                    .SPM.KakaoSDKUser,
                    .SPM.Alamofire,
                    .SPM.FirebaseAnalytics,
                    .SPM.FirebaseCrashlytics,
                    .SPM.FirebaseMessaging
                ]
            )
        ),
    ]
)
