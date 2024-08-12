//
//  Project+Templates.swift
//  Bottles_iOSManifests
//
//  Created by 임현규 on 7/17/24.
//

import ProjectDescription

public extension Project {
    static func makeModule(name: String, targets: [Target], schemes: [Scheme] = [], resourceSynthesizers: [ResourceSynthesizer] = []) -> Self {
        let name: String = name
        let organizationName: String? = nil
        let options: Project.Options = .options(
            defaultKnownRegions: ["en", "ko"],
            developmentRegion: "ko",
            textSettings: .textSettings(indentWidth: 2, tabWidth: 2)
        )
        let packages: [Package] = []
        let settings: Settings? = .projectSettings
        let targets: [Target] = targets
        let schemes: [Scheme] = schemes
        let fileHeaderTemplate: FileHeaderTemplate? = nil
        let additionalFiles: [FileElement] = []
        
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
