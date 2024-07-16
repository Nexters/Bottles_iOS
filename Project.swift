import ProjectDescription

let project = Project(
    name: "Bottles_iOS",
    targets: [
        .target(
            name: "Bottles_iOS",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.Bottles-iOS",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["Bottles_iOS/Sources/**"],
            resources: ["Bottles_iOS/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "Bottles_iOSTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.Bottles-iOSTests",
            infoPlist: .default,
            sources: ["Bottles_iOS/Tests/**"],
            resources: [],
            dependencies: [.target(name: "Bottles_iOS")]
        ),
    ]
)
