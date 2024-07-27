import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Shared.name+ModulePath.Shared.DesignSystemThirdPartyLib.rawValue,
    targets: [    
        .shared(
            interface: .DesignSystemThirdPartyLib,
            factory: .init()
        ),
        .shared(
            implements: .DesignSystemThirdPartyLib,
            factory: .init(
                dependencies: [
                    .shared(interface: .DesignSystemThirdPartyLib),
                    .SPM.Kingfisher,
                ]
            )
        ),
    ]
)
