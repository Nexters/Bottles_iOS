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
    .domain(factory: .init(
        sources: nil,
        dependencies: [
            .core
        ] + ModulePath.Domain.allCases.map {
            .domain(implements: $0)
        }
    ))
]

let project = Project.makeModule(
    name: "Domain",
    targets: targets
)
