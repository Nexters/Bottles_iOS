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
            "CFBundleShortVersionString": "1.0.7",
            "CFBundleVersion": "27",
            "UIUserInterfaceStyle": "Light",
            "CFBundleName": "보틀",
            "UILaunchScreen": [
                "UIImageName": "splashImage",
                "UIColorName": "splashColor"
            ],
            "CFBundleIconName": "AppIcon",
            "UISupportedInterfaceOrientations": [
                "UIInterfaceOrientationPortrait"
            ],
            "BASE_URL": "$(BASE_URL)",
            "WEB_VIEW_BASE_URL": "$(WEB_VIEW_BASE_URL)",
            "WEB_VIEW_MESSAGE_HANDLER_DEFAULT_NAME": "$(WEB_VIEW_MESSAGE_HANDLER_DEFAULT_NAME)",
            "APP_STORE_URL": "$(APP_STORE_URL)",
            "LSApplicationQueriesSchemes": ["kakaokompassauth", "kakaotalk"],
            "CFBundleURLTypes": [
                [
                    "CFBundleTypeRole": "Editor",
                    "CFBundleURLSchemes": ["kakao$(KAKAO_APP_KEY)"]
                ]
            ],
            "KAKAO_APP_KEY": "$(KAKAO_APP_KEY)",
            "UIBackgroundModes": ["remote-notification"]
        ])
    }
    
    static var example: InfoPlist {
        return .extendingDefault(with: [
            "CFBundleShortVersionString": "1.0.7",
            "CFBundleVersion": "27",
            "UIUserInterfaceStyle": "Light",
            "UILaunchScreen": [:],
            "UISupportedInterfaceOrientations": [
                "UIInterfaceOrientationPortrait"
            ],
            "BASE_URL": "$(BASE_URL)",
            "WEB_VIEW_BASE_URL": "$(WEB_VIEW_BASE_URL)",
            "WEB_VIEW_MESSAGE_HANDLER_DEFAULT_NAME": "$(WEB_VIEW_MESSAGE_HANDLER_DEFAULT_NAME)",
            "APP_STORE_URL": "$(APP_STORE_URL)",
            "LSApplicationQueriesSchemes": ["kakaokompassauth", "kakaotalk"],
            "CFBundleURLTypes": [
                [
                    "CFBundleTypeRole": "Editor",
                    "CFBundleURLSchemes": ["kakao$(KAKAO_APP_KEY)"]
                ]
            ],
            "KAKAO_APP_KEY": "$(KAKAO_APP_KEY)",
            "UIBackgroundModes": ["remote-notification"]
        ])
    }
}
