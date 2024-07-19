// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        productTypes: [
            "ComposableArchitecture": .framework,
            "Kingfisher": .framework,
            "Alamofire": .framework,
            "Moya": .framework,
        ],
        baseSettings: .settings(
            configurations: [
                .debug(name: "debug"),
                .release(name: "release")
            ]
        )
    )
#endif

let package = Package(
    name: "Bottles_iOS",
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.11.2"),
        .package(url: "https://github.com/onevcat/Kingfisher", from: "7.12.0"),
        .package(url: "https://github.com/Alamofire/Alamofire", from: "5.9.1"),
        .package(url: "https://github.com/Moya/Moya.git", exact: "15.0.3")
    ]
)
