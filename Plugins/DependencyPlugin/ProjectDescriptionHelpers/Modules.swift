//
//  Modules.swift
//  DependencyPlugin
//
//  Created by 임현규 on 7/17/24.
//

import ProjectDescription

public enum ModulePath {
    case feature(Feature)
    case domain(Domain)
    case core(Core)
    case shared(Shared)
}

// MARK: - AppModule

public extension ModulePath {
    enum App: String, CaseIterable {
        case iOS
        public static let name: String = "App"
    }
}


// MARK: - FeatureModule
public extension ModulePath {
    enum Feature: String, CaseIterable {
        case Onboarding
        case MyPage
        case BottleStorage
        case SandBeach
        case Login

        public static let name: String = "Feature"
    }
}

// MARK: - DomainModule

public extension ModulePath {
    enum Domain: String, CaseIterable {
        case Bottle
        case Profile
        case Auth

        public static let name: String = "Domain"
    }
}

// MARK: - CoreModule

public extension ModulePath {
    enum Core: String, CaseIterable {
        case KeyChainStore
        case WebView
        case Util
        case Logger
        case Network

        public static let name: String = "Core"
    }
}

// MARK: - SharedModule

public extension ModulePath {
    enum Shared: String, CaseIterable {
        case DesignSystemThirdPartyLib
        case ThirdPartyLib
        case DesignSystem
        case Util
        
        public static let name: String = "Shared"
    }
}
