// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription
    import ProjectDescriptionHelpers
    import ConfiguratipnPlugin
    
    let packageSettings = PackageSettings(
        productTypes: [
            "ComposableArchitecture": .framework,
            "Kingfisher": .framework,
            "Alamofire": .framework,
            "Moya": .framework,
            "KakaoSDK": .framework,
            "Lottie": .framework,
            "FirebaseAnalytics": .staticLibrary,
            "FirebaseMessaging": .staticLibrary,
            "FirebaseCrashlytics": .staticLibrary,
        ],
        baseSettings: .packageSettings
    )
#endif

let package = Package(
    name: "Bottles_iOS",
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.11.2"),
        .package(url: "https://github.com/onevcat/Kingfisher", from: "7.12.0"),
        .package(url: "https://github.com/Alamofire/Alamofire", from: "5.9.1"),
        .package(url: "https://github.com/Moya/Moya.git", exact: "15.0.3"),
        .package(url: "https://github.com/kakao/kakao-ios-sdk.git", exact: "2.22.5"),
        .package(url: "https://github.com/airbnb/lottie-ios", from: "4.5.0"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "11.1.0")
    ]
)
