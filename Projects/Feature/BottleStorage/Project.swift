import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Feature.name+ModulePath.Feature.BottleStorage.rawValue,
    targets: [
        .feature(
            interface: .BottleStorage,
            factory: .init(
                dependencies: [
                    .domain,
                    .feature(interface: .Report),
                    .feature(interface: .TabBar)

                ]
            )
        ),
        .feature(
            implements: .BottleStorage,
            factory: .init(
                dependencies: [
                    .feature(interface: .BottleStorage)
                ]
            )
        ),
    
        .feature(
            testing: .BottleStorage,
            factory: .init(
                dependencies: [
                    .feature(interface: .BottleStorage)
                ]
            )
        ),
        .feature(
            tests: .BottleStorage,
            factory: .init(
                dependencies: [
                    .feature(testing: .BottleStorage),
                    .feature(implements: .BottleStorage)
                ]
            )
        ),
    
        .feature(
            example: .BottleStorage,
            factory: .init(
                dependencies: [
                    .feature(testing: .BottleStorage),
                    .feature(implements: .BottleStorage)
                ]
            )
        )

    ]
)
