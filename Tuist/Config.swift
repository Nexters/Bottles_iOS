//
//  Config.swift
//  Packages
//
//  Created by 임현규 on 7/18/24.
//

import ProjectDescription

let config = Config(
    plugins: [
        .local(path: .relativeToRoot("Plugins/DependencyPlugin")),
        .local(path: .relativeToRoot("Plugins/ConfigurationPlugin"))
    ]
)
