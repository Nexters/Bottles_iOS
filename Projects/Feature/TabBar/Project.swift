import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Feature.name+ModulePath.Feature.TabBar.rawValue,
    targets: [    
        .feature(
            interface: .TabBar,
            factory: .init(dependencies: [
                .domain
            ])
        ),
        .feature(
            implements: .TabBar,
            factory: .init(
                dependencies: [
                    .feature(interface: .TabBar)
                ]
            )
        ),
    
        .feature(
            testing: .TabBar,
            factory: .init(
                dependencies: [
                    .feature(interface: .TabBar)
                ]
            )
        ),
        .feature(
            tests: .TabBar,
            factory: .init(
                dependencies: [
                    .feature(testing: .TabBar),
                    .feature(implements: .TabBar)
                ]
            )
        ),
    
        .feature(
            example: .TabBar,
            factory: .init(
                dependencies: [
                    .feature(testing: .TabBar),
                    .feature(implements: .TabBar)
                ]
            )
        )

    ]
)
