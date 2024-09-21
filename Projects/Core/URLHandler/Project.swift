import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Core.name+ModulePath.Core.URLHandler.rawValue,
    targets: [    
        .core(
            interface: .URLHandler,
            factory: .init()
        ),
        .core(
            implements: .URLHandler,
            factory: .init(
                dependencies: [
                    .core(interface: .URLHandler)
                ]
            )
        ),
    
        .core(
            testing: .URLHandler,
            factory: .init(
                dependencies: [
                    .core(interface: .URLHandler)
                ]
            )
        ),
        .core(
            tests: .URLHandler,
            factory: .init(
                dependencies: [
                    .core(testing: .URLHandler),
                    .core(implements: .URLHandler)
                ]
            )
        ),

    ]
)
