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
    .feature(factory: .init(
        product: .staticFramework,
        sources: .sources,
        dependencies: [
          
        ] + ModulePath.Feature.allCases.map {
            .feature(implements: $0)
        }
    ))
]

let project = Project.makeModule(
    name: "Feature",
    targets: targets
)
