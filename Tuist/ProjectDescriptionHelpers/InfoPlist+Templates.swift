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
            "CFBundleShortVersionString": "1.0.8",
            "CFBundleVersion": "30",
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
            "NSContactsUsageDescription": "매칭 차단 기능을 위해 연락처가 필요합니다.",
            "BASE_URL": "$(BASE_URL)",
            "WEB_VIEW_BASE_URL": "$(WEB_VIEW_BASE_URL)",
            "WEB_VIEW_MESSAGE_HANDLER_DEFAULT_NAME": "$(WEB_VIEW_MESSAGE_HANDLER_DEFAULT_NAME)",
            "APP_STORE_URL": "$(APP_STORE_URL)",
            "APP_LOOK_UP_URL": "$(APP_LOOK_UP_URL)",
            "KAKAO_CHANNEL_TALK_URL": "$(KAKAO_CHANNEL_TALK_URL)",
            "ADMIN_PATH": "$(ADMIN_PATH)",
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
            "CFBundleShortVersionString": "1.0.8",
            "CFBundleVersion": "30",
            "UIUserInterfaceStyle": "Light",
            "UILaunchScreen": [:],
            "UISupportedInterfaceOrientations": [
                "UIInterfaceOrientationPortrait"
            ],
            "NSContactsUsageDescription": "매칭 차단 기능을 위해 연락처가 필요합니다.",
            "BASE_URL": "$(BASE_URL)",
            "WEB_VIEW_BASE_URL": "$(WEB_VIEW_BASE_URL)",
            "WEB_VIEW_MESSAGE_HANDLER_DEFAULT_NAME": "$(WEB_VIEW_MESSAGE_HANDLER_DEFAULT_NAME)",
            "APP_STORE_URL": "$(APP_STORE_URL)",
            "KAKAO_CHANNEL_TALK_URL": "$(KAKAO_CHANNEL_TALK_URL)",
            "APP_LOOK_UP_URL": "$(APP_LOOK_UP_URL)",
            "ADMIN_PATH": "$(ADMIN_PATH)",
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
