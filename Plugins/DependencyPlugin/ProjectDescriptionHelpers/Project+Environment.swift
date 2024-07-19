//
//  Project+Environment.swift
//  DependencyPlugin
//
//  Created by 임현규 on 7/17/24.
//

import ProjectDescription

public extension Project {
    enum Environment {
        public static let appName = "Bottle"
        public static let deploymentTarget = DeploymentTargets.iOS("16.0")
        public static let bundlePrefix = "com.bottles.bottle"
    }
}
