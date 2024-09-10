import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Domain.name+ModulePath.Domain.Error.rawValue,
    targets: [    
        .domain(
            interface: .Error,
            factory: .init()
        ),
        .domain(
            implements: .Error,
            factory: .init(
                dependencies: [
                    .domain(interface: .Error)
                ]
            )
        ),

    ]
)
