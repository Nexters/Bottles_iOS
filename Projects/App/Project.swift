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
    name: Project.Environment.appName,
    targets: targets,
    schemes: [
        .makeScheme(.dev, name: Project.Environment.appName),
        .makeScheme(.prod, name: Project.Environment.appName),
        .makeScheme(.test, name: Project.Environment.appName)
    ]
)

