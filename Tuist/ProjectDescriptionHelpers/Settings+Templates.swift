//
//  Settings+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by 임현규 on 7/19/24.
//

import ProjectDescription

public extension ProjectDescription.Settings {
    static var projectSettings: Self {
        return .settings(
            base: ["OTHER_LDFLAGS":["-all_load -Objc"]],
            configurations: [
                .debug(name: .dev, xcconfig: .relativeToRoot("XCConfig/App/DEV.xcconfig")),
                .debug(name: .test, xcconfig: .relativeToRoot("XCConfig/App/TEST.xcconfig")),
                .release(name: .prod, xcconfig: .relativeToRoot("XCConfig/App/PROD.xcconfig")),
            ]
        )
    }
    
    static var targetSettings: Self {
        return .settings(
            configurations: [
                .debug(name: .dev, xcconfig: .relativeToRoot("XCConfig/App/DEV.xcconfig")),
                .debug(name: .test, xcconfig: .relativeToRoot("XCConfig/App/TEST.xcconfig")),
                .release(name: .prod, xcconfig: .relativeToRoot("XCConfig/App/PROD.xcconfig")),
            ]
        )
    }
    
    static var packageSettings: Self {
        return .settings(
            configurations: [
                .debug(name: .dev),
                .debug(name: .test),
                .release(name: .prod),
            ]
        )
    }
}
