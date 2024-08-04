import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Feature.name+ModulePath.Feature.GeneralSignUp.rawValue,
    targets: [    
        .feature(
            interface: .GeneralSignUp,
            factory: .init(
                dependencies: [
                    .domain,
                    .feature(interface: .BaseWebView)
                ]
            )
        ),
        .feature(
            implements: .GeneralSignUp,
            factory: .init(
                dependencies: [
                    .feature(interface: .GeneralSignUp)
                ]
            )
        ),
    
        .feature(
            testing: .GeneralSignUp,
            factory: .init(
                dependencies: [
                    .feature(interface: .GeneralSignUp)
                ]
            )
        ),
        .feature(
            tests: .GeneralSignUp,
            factory: .init(
                dependencies: [
                    .feature(testing: .GeneralSignUp),
                    .feature(implements: .GeneralSignUp)
                ]
            )
        ),
    
        .feature(
            example: .GeneralSignUp,
            factory: .init(
                dependencies: [
                    .feature(testing: .GeneralSignUp),
                    .feature(implements: .GeneralSignUp)
                ]
            )
        )

    ]
)
