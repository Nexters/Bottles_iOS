import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Feature.name+ModulePath.Feature.BaseWebView.rawValue,
    targets: [
        .feature(
            interface: .BaseWebView,
            factory: .init(
                dependencies: [
                    .domain
                ]
            )
        ),
        .feature(
            implements: .BaseWebView,
            factory: .init(
                dependencies: [
                    .feature(interface: .BaseWebView)
                ]
            )
        ),
    
        .feature(
            testing: .BaseWebView,
            factory: .init(
                dependencies: [
                    .feature(interface: .BaseWebView)
                ]
            )
        ),
        .feature(
            tests: .BaseWebView,
            factory: .init(
                dependencies: [
                    .feature(testing: .BaseWebView),
                    .feature(implements: .BaseWebView)
                ]
            )
        ),
    
        .feature(
            example: .BaseWebView,
            factory: .init(
                dependencies: [
                    .feature(testing: .BaseWebView),
                    .feature(implements: .BaseWebView)
                ]
            )
        )
    ]
)
