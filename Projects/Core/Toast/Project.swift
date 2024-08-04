import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Core.name+ModulePath.Core.Toast.rawValue,
    targets: [    
        .core(
            interface: .Toast,
            factory: .init(
                dependencies: [
                    .shared,
                    .shared(implements: .ThirdPartyLib)
                ]
            )
        ),
        .core(
            implements: .Toast,
            factory: .init(
                dependencies: [
                    .core(interface: .Toast)
                ]
            )
        ),
    
        .core(
            testing: .Toast,
            factory: .init(
                dependencies: [
                    .core(interface: .Toast)
                ]
            )
        ),
        .core(
            tests: .Toast,
            factory: .init(
                dependencies: [
                    .core(testing: .Toast),
                    .core(implements: .Toast)
                ]
            )
        ),

    ]
)
