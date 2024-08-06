import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Core.name+ModulePath.Core.WebView.rawValue,
    targets: [    
        .core(
            interface: .WebView,
            factory: .init(
              dependencies: [
                  .shared(implements: .ThirdPartyLib)
              ]
            )
        ),
        .core(
            implements: .WebView,
            factory: .init(
                dependencies: [
                    .core(interface: .WebView)
                ]
            )
        ),
    
        .core(
            testing: .WebView,
            factory: .init(
                dependencies: [
                    .core(interface: .WebView)
                ]
            )
        ),
        .core(
            tests: .WebView,
            factory: .init(
                dependencies: [
                    .core(testing: .WebView),
                    .core(implements: .WebView)
                ]
            )
        ),

    ]
)
