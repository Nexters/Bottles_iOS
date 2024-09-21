import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Domain.name+ModulePath.Domain.Application.rawValue,
    targets: [    
        .domain(
            interface: .Application,
            factory: .init(
                dependencies: [
                    .core
                ]
            )
        ),
        .domain(
            implements: .Application,
            factory: .init(
                dependencies: [
                    .domain(interface: .Application)
                ]
            )
        ),
    
        .domain(
            testing: .Application,
            factory: .init(
                dependencies: [
                    .domain(interface: .Application)
                ]
            )
        ),
        .domain(
            tests: .Application,
            factory: .init(
                dependencies: [
                    .domain(testing: .Application),
                    .domain(implements: .Application)
                ]
            )
        ),

    ]
)
