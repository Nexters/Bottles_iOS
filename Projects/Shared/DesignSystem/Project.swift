import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Shared.name+ModulePath.Shared.DesignSystem.rawValue,
    targets: [    
        .shared(
            interface: .DesignSystem,
            factory: .init()
        ),
        .shared(
            implements: .DesignSystem,
            factory: .init(
                dependencies: [
                    .shared(interface: .DesignSystem)
                ]
            )
        ),
    ],
    resourceSynthesizers: [
        .assets(),
        .fonts()
    ]
)
