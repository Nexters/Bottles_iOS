import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Feature.name+ModulePath.Feature.Login.rawValue,
    targets: [    
        .feature(
            interface: .Login,
            factory: .init(
                dependencies: [
                    .domain
                ]
            )
        ),
        .feature(
            implements: .Login,
            factory: .init(
                dependencies: [
                    .feature(interface: .Login)
                ]
            )
        ),
    
        .feature(
            testing: .Login,
            factory: .init(
                dependencies: [
                    .feature(interface: .Login)
                ]
            )
        ),
        .feature(
            tests: .Login,
            factory: .init(
                dependencies: [
                    .feature(testing: .Login),
                    .feature(implements: .Login)
                ]
            )
        ),
    
        .feature(
            example: .Login,
            factory: .init(
                dependencies: [
                    .feature(testing: .Login),
                    .feature(implements: .Login)
                ]
            )
        )

    ]
)
