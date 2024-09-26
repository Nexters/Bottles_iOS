import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Shared.name+ModulePath.Shared.DesignSystemThirdPartyLib.rawValue,
    targets: [
        .shared(
            implements: .DesignSystemThirdPartyLib,
            factory: .init(
                dependencies: [
                    .SPM.Kingfisher,
                    .SPM.Lottie,
                    .SPM.ComposableArchitecture
                ]
            )
        ),
    ]
)
