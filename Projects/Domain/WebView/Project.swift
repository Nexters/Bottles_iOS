import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Domain.name+ModulePath.Domain.WebView.rawValue,
    targets: [    
        .domain(
            interface: .WebView,
            factory: .init()
        ),
        .domain(
            implements: .WebView,
            factory: .init(
                dependencies: [
                    .domain(interface: .WebView)
                ]
            )
        ),
    
        .domain(
            testing: .WebView,
            factory: .init(
                dependencies: [
                    .domain(interface: .WebView)
                ]
            )
        ),
        .domain(
            tests: .WebView,
            factory: .init(
                dependencies: [
                    .domain(testing: .WebView),
                    .domain(implements: .WebView)
                ]
            )
        ),

    ]
)
