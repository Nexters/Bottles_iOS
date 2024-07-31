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
            "UIUserInterfaceStyle": "Light",
            "UILaunchScreen": [:],
            "UISupportedInterfaceOrientations": [
                "UIInterfaceOrientationPortrait"
            ],
            "BASE_URL": "$(BASE_URL)",
            "KAKAO_APP_KEY": "$(KAKAO_APP_KEY)",
            "LSApplicationQueriesSchemes": ["kakaokompassauth"],
            "CFBundleURLTypes": [
                "CFBundleTypeRole": "Editor",
                "CFBundleURLSchemes": [
                    "kakao$(KAKAO_APP_KEY)://oauth"
                ]
            ]
        ])
    }
    
    static var example: InfoPlist {
        return .extendingDefault(with: [
            "UIUserInterfaceStyle": "Light",
            "UILaunchScreen": [:],
            "UISupportedInterfaceOrientations": [
                "UIInterfaceOrientationPortrait"
            ],
            "BASE_URL": "$(BASE_URL)",
            "KAKAO_APP_KEY": "$(KAKAO_APP_KEY)",
            "LSApplicationQueriesSchemes": ["kakaokompassauth"],
            "CFBundleURLTypes": [
                "CFBundleTypeRole": "Editor",
                "CFBundleURLSchemes": [
                    "kakao$(KAKAO_APP_KEY)://oauth"
                ]
            ]
        ])
    }
}
