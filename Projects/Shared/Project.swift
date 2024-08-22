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
    .shared(factory: .init(
        product: .staticFramework,
        sources: nil,
        dependencies: [
            .shared(implements: .DesignSystem),
            .shared(implements: .Util)
        ]
    ))
]

let project = Project.makeModule(
    name: "Shared",
    targets: targets
)
