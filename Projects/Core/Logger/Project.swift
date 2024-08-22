import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Core.name+ModulePath.Core.Logger.rawValue,
    targets: [    
        .core(
            interface: .Logger,
            factory: .init()
        ),
        .core(
            implements: .Logger,
            factory: .init(
                dependencies: [
                    .core(interface: .Logger)
                ]
            )
        ),
    
        .core(
            testing: .Logger,
            factory: .init(
                dependencies: [
                    .core(interface: .Logger)
                ]
            )
        ),
        .core(
            tests: .Logger,
            factory: .init(
                dependencies: [
                    .core(testing: .Logger),
                    .core(implements: .Logger)
                ]
            )
        ),

    ]
)
