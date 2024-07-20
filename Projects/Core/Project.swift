//
//  Project.swift
//  AppManifests
//
//  Created by 임현규 on 7/19/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let targets: [Target] = [
    .core(factory: .init(
        product: .framework,
        sources: nil,
        dependencies: [
            .shared
        ] + ModulePath.Core.allCases.map {
            .core(implements: $0)
        }
    ))
]

let project = Project.makeModule(
    name: "Core",
    targets: targets
)
