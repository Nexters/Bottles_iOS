//
//  Project+Templates.swift
//  Bottles_iOSManifests
//
//  Created by 임현규 on 7/17/24.
//

import ProjectDescription

public extension Project {
    static func makeModule(name: String, targets: [Target]) -> Self {
        let name: String = name
        let organizationName: String? = nil
        let options: Project.Options = .options()
        let packages: [Package] = []
        let settings: Settings? = .settings(configurations: [
            .debug(name: "debug"),
            .release(name: "release")
        ])
        let targets: [Target] = targets
        let schemes: [Scheme] = []
        let fileHeaderTemplate: FileHeaderTemplate? = nil
        let additionalFiles: [FileElement] = []
        let resourceSynthesizers: [ResourceSynthesizer] = []
        
        return .init(
            name: name,
            organizationName: organizationName,
            options: options,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes,
            fileHeaderTemplate: fileHeaderTemplate,
            additionalFiles: additionalFiles,
            resourceSynthesizers: resourceSynthesizers
        )
    }
}
