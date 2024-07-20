//
//  ProjectDeployTarget.swift
//  ProjectDescriptionHelpers
//
//  Created by 임현규 on 7/19/24.
//

import ProjectDescription

public enum ProjectDeployTarget: String {
    case dev = "DEV"
    case prod = "PROD"
    case test = "TEST"
    
    public var configurationName: ConfigurationName {
        ConfigurationName.configuration(self.rawValue)
    }
}
