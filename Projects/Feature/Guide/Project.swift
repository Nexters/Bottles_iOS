import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Feature.name+ModulePath.Feature.Guide.rawValue,
    targets: [    
        .feature(
            interface: .Guide,
            factory: .init(dependencies: [
                .core
            ])
        ),
        .feature(
            implements: .Guide,
            factory: .init(
                dependencies: [
                    .feature(interface: .Guide)
                ]
            )
        ),
    
        .feature(
            testing: .Guide,
            factory: .init(
                dependencies: [
                    .feature(interface: .Guide)
                ]
            )
        ),
        .feature(
            tests: .Guide,
            factory: .init(
                dependencies: [
                    .feature(testing: .Guide),
                    .feature(implements: .Guide)
                ]
            )
        ),
    
        .feature(
            example: .Guide,
            factory: .init(
                dependencies: [
                    .feature(testing: .Guide),
                    .feature(implements: .Guide)
                ]
            )
        )

    ]
)
