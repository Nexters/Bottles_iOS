import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Domain.name+ModulePath.Domain.SandBeach.rawValue,
    targets: [    
        .domain(
            interface: .SandBeach,
            factory: .init(dependencies: [
                .core
            ])
        ),
        .domain(
            implements: .SandBeach,
            factory: .init(
                dependencies: [
                    .domain(interface: .SandBeach)
                ]
            )
        ),
    
        .domain(
            testing: .SandBeach,
            factory: .init(
                dependencies: [
                    .domain(interface: .SandBeach)
                ]
            )
        ),
        .domain(
            tests: .SandBeach,
            factory: .init(
                dependencies: [
                    .domain(testing: .SandBeach),
                    .domain(implements: .SandBeach)
                ]
            )
        ),

    ]
)
