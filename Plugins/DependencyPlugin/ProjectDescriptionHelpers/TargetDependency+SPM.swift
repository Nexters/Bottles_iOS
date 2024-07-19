//
//  TargetDependency+SPM.swift
//  DependencyPlugin
//
//  Created by 임현규 on 7/19/24.
//

import ProjectDescription

public extension TargetDependency {
    struct SPM {}
}

public extension TargetDependency.SPM {
    static let ComposableArchitecture: TargetDependency = .external(name: "ComposableArchitecture")
    static let Kingfisher: TargetDependency = .external(name: "Kingfisher")
    static let Alamofire: TargetDependency = .external(name: "Alamofire")
    static let Moya: TargetDependency = .external(name: "Moya")
}
