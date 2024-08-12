import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Feature.name+ModulePath.Feature.Report.rawValue,
    targets: [    
        .feature(
            interface: .Report,
            factory: .init(
                dependencies: [
                    .domain
                ]
            )
        ),
        .feature(
            implements: .Report,
            factory: .init(
                dependencies: [
                    .feature(interface: .Report)
                ]
            )
        ),
    
        .feature(
            testing: .Report,
            factory: .init(
                dependencies: [
                    .feature(interface: .Report)
                ]
            )
        ),
        .feature(
            tests: .Report,
            factory: .init(
                dependencies: [
                    .feature(testing: .Report),
                    .feature(implements: .Report)
                ]
            )
        ),
    
        .feature(
            example: .Report,
            factory: .init(
                dependencies: [
                    .feature(testing: .Report),
                    .feature(implements: .Report)
                ]
            )
        )

    ]
)
