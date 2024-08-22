import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Feature.name+ModulePath.Feature.BottleArrival.rawValue,
    targets: [    
        .feature(
            interface: .BottleArrival,
            factory: .init(dependencies: [
                .domain,
                .feature(interface: .BaseWebView)
            ])
        ),
        .feature(
            implements: .BottleArrival,
            factory: .init(
                dependencies: [
                    .feature(interface: .BottleArrival)
                ]
            )
        ),
    
        .feature(
            testing: .BottleArrival,
            factory: .init(
                dependencies: [
                    .feature(interface: .BottleArrival)
                ]
            )
        ),
        .feature(
            tests: .BottleArrival,
            factory: .init(
                dependencies: [
                    .feature(testing: .BottleArrival),
                    .feature(implements: .BottleArrival)
                ]
            )
        ),
    
        .feature(
            example: .BottleArrival,
            factory: .init(
                dependencies: [
                    .feature(testing: .BottleArrival),
                    .feature(implements: .BottleArrival)
                ]
            )
        )

    ]
)
