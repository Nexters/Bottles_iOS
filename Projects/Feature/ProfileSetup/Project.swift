import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Feature.name+ModulePath.Feature.ProfileSetup.rawValue,
    targets: [    
        .feature(
            interface: .ProfileSetup,
            factory: .init(
                dependencies: [
                    .domain
                ]
            )
        ),
        .feature(
            implements: .ProfileSetup,
            factory: .init(
                dependencies: [
                    .feature(interface: .ProfileSetup)
                ]
            )
        ),
    
        .feature(
            testing: .ProfileSetup,
            factory: .init(
                dependencies: [
                    .feature(interface: .ProfileSetup)
                ]
            )
        ),
        .feature(
            tests: .ProfileSetup,
            factory: .init(
                dependencies: [
                    .feature(testing: .ProfileSetup),
                    .feature(implements: .ProfileSetup)
                ]
            )
        ),
    
        .feature(
            example: .ProfileSetup,
            factory: .init(
                dependencies: [
                    .feature(testing: .ProfileSetup),
                    .feature(implements: .ProfileSetup)
                ]
            )
        )

    ]
)
