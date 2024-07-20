//
//  InfoPlist+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by 임현규 on 7/21/24.
//

import ProjectDescription

public extension InfoPlist {
    static var app: InfoPlist {
        return .extendingDefault(with: [
            "BaseURL": "$(BASE_URL)"
        ])
    }
    
    static var example: InfoPlist {
        return .extendingDefault(with: [
            "BaseURL": "$(BASE_URL)"
        ])
    }
}
