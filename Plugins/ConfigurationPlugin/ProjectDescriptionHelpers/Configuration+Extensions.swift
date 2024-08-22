//
//  Configuration+Extensions.swift
//  ConfiguratipnPlugin
//
//  Created by 임현규 on 7/19/24.
//

import ProjectDescription

public extension ConfigurationName {
    static var dev: ConfigurationName { configuration(ProjectDeployTarget.dev.rawValue) }
    static var prod: ConfigurationName { configuration(ProjectDeployTarget.prod.rawValue) }
    static var test: ConfigurationName { configuration(ProjectDeployTarget.test.rawValue) }
}
