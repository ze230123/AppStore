//
//  Bundle+Extension.swift
//  AppStore
//
//  Created by 泽i on 2017/10/31.
//  Copyright © 2017年 泽i. All rights reserved.
//

extension Bundle {
    
    /// 应用程序的编译号
    static var build: String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
    }

    /// 应用程序版本号
    static var versionNumber: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    /// 应用程序名
    static var displayName: String {
        return Bundle.main.localizedInfoDictionary?["CFBundleDisplayName"] as? String ?? ""
    }

    static var bundleId: String {
        return Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String ?? ""
    }
}

