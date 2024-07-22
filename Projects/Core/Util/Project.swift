import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Core.name+ModulePath.Core.Util.rawValue,
    targets: [    
        .core(
            interface: .Util,
            factory: .init()
        ),
        .core(
            implements: .Util,
            factory: .init(
                dependencies: [
                    .core(interface: .Util)
                ]
            )
        ),

    ]
)
