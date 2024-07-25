import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Core.name+ModulePath.Core.Network.rawValue,
    targets: [    
        .core(
            interface: .Network,
            factory: .init(
                dependencies: [
                    .shared(implements: .ThirdPartyLib)
                ]
            )
        ),
        .core(
            implements: .Network,
            factory: .init(
                dependencies: [
                    .core(interface: .Network),
                    .core(interface: .Logger)
                ]
            )
        ),
    
        .core(
            testing: .Network,
            factory: .init(
                dependencies: [
                    .core(interface: .Network)
                ]
            )
        ),
        .core(
            tests: .Network,
            factory: .init(
                dependencies: [
                    .core(testing: .Network),
                    .core(implements: .Network)
                ]
            )
        ),

    ]
)
