import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Feature.name+ModulePath.Feature.GoodFeeling.rawValue,
    targets: [
        .feature(
            interface: .GoodFeeling,
            factory: .init(
                dependencies: [
                    .domain,
                    .feature(interface: .TabBar),
                    .feature(interface: .BaseWebView)
                ]
            )
        ),
        .feature(
            implements: .GoodFeeling,
            factory: .init(
                dependencies: [
                    .feature(interface: .GoodFeeling)
                ]
            )
        ),
        .feature(
            testing: .GoodFeeling,
            factory: .init(
                dependencies: [
                    .feature(interface: .GoodFeeling)
                ]
            )
        ),
        .feature(
            tests: .GoodFeeling,
            factory: .init(
                dependencies: [
                    .feature(testing: .GoodFeeling),
                    .feature(implements: .GoodFeeling)
                ]
            )
        ),
        .feature(
            example: .GoodFeeling,
            factory: .init(
                dependencies: [
                    .feature(testing: .GoodFeeling),
                    .feature(implements: .GoodFeeling)
                ]
            )
        )
    ]
)
