import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Feature.name+ModulePath.Feature.SandBeach.rawValue,
    targets: [
        .feature(
            interface: .SandBeach,
            factory: .init(
                dependencies: [
                    .domain,
                    .feature(interface: .ProfileSetup)
                ]
            )
        ),
        .feature(
            implements: .SandBeach,
            factory: .init(
                dependencies: [
                    .feature(interface: .SandBeach)
                ]
            )
        ),
    
        .feature(
            testing: .SandBeach,
            factory: .init(
                dependencies: [
                    .feature(interface: .SandBeach)
                ]
            )
        ),
        .feature(
            tests: .SandBeach,
            factory: .init(
                dependencies: [
                    .feature(testing: .SandBeach),
                    .feature(implements: .SandBeach)
                ]
            )
        ),
    
        .feature(
            example: .SandBeach,
            factory: .init(
                dependencies: [
                    .feature(testing: .SandBeach),
                    .feature(implements: .SandBeach)
                ]
            )
        )

    ]
)
