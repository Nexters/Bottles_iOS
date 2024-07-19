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
        sources: nil,
        dependencies: ModulePath.Shared.allCases.map {
            .shared(implements: $0)
        }
    ))
]

let project = Project.makeModule(
    name: "Shared",
    targets: targets
)
