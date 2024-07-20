//
//  Scheme+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by 임현규 on 7/19/24.
//

import ProjectDescription
import ConfiguratipnPlugin

public extension Scheme {
    static func makeScheme(_ type: ProjectDeployTarget, name: String) -> Self {
        let buildName = type.rawValue
        switch type {
        case .dev:
            return .scheme(
                name: "\(name)-\(buildName)",
                shared: true,
                buildAction: .buildAction(targets: ["\(name)"]),
                runAction: .runAction(configuration: .dev),
                archiveAction: .archiveAction(configuration: .dev),
                profileAction: .profileAction(configuration: .dev),
                analyzeAction: .analyzeAction(configuration: .dev)
            )
        case .prod:
            return .scheme(
                name: "\(name)-\(buildName)",
                shared: true,
                buildAction: .buildAction(targets: ["\(name)"]),
                runAction: .runAction(configuration: .prod),
                archiveAction: .archiveAction(configuration: .prod),
                profileAction: .profileAction(configuration: .prod),
                analyzeAction: .analyzeAction(configuration: .prod)
            )
        case .test:
            return .scheme(
                name: "\(name)-\(buildName)",
                shared: true,
                buildAction: .buildAction(targets: ["\(name)"]),
                runAction: .runAction(configuration: .test),
                archiveAction: .archiveAction(configuration: .test),
                profileAction: .profileAction(configuration: .test),
                analyzeAction: .analyzeAction(configuration: .test)
            )
        }
    }
}
