import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Domain.name+ModulePath.Domain.Profile.rawValue,
    targets: [    
        .domain(
            interface: .Profile,
            factory: .init(dependencies: [
                .core
            ])
        ),
        .domain(
            implements: .Profile,
            factory: .init(
                dependencies: [
                    .domain(interface: .Profile)
                ]
            )
        ),
    
        .domain(
            testing: .Profile,
            factory: .init(
                dependencies: [
                    .domain(interface: .Profile)
                ]
            )
        ),
        .domain(
            tests: .Profile,
            factory: .init(
                dependencies: [
                    .domain(testing: .Profile),
                    .domain(implements: .Profile)
                ]
            )
        ),

    ]
)
