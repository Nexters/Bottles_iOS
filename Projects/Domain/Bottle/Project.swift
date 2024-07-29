import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Domain.name+ModulePath.Domain.Bottle.rawValue,
    targets: [    
        .domain(
            interface: .Bottle,
            factory: .init(
                dependencies: [
                    .core
                ]
            )
        ),
        .domain(
            implements: .Bottle,
            factory: .init(
                dependencies: [
                    .domain(interface: .Bottle)
                ]
            )
        ),
    
        .domain(
            testing: .Bottle,
            factory: .init(
                dependencies: [
                    .domain(interface: .Bottle)
                ]
            )
        ),
        .domain(
            tests: .Bottle,
            factory: .init(
                dependencies: [
                    .domain(testing: .Bottle),
                    .domain(implements: .Bottle)
                ]
            )
        ),

    ]
)
