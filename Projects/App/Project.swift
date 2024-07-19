import ProjectDescription
import ProjectDescriptionHelpers

let targets: [Target] = [
    .app(implements: .iOS, factory: .init(
        infoPlist: .extendingDefault(
            with: [
                "UILaunchScreen": [
                    "UIColorName": "",
                    "UIImageName": "",
                ],
            ]
        ),
        
        dependencies: [
            .feature
    ]))
]
let project = Project.makeModule(
    name: "App",
    targets: targets
)
