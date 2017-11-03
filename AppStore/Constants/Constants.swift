//
//  Constants.swift
//  AppStore
//
//  Created by 泽i on 2017/10/27.
//  Copyright © 2017年 泽i. All rights reserved.
//
// MARK: - 全局方法
/// Debug下输出，Relese下不会执行
func printLog(_ items: Any..., file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
        print((file as NSString).lastPathComponent, "line:[\(line)]", method, separator: " ", terminator: " ")
        for item in items {
            print(item, separator: " ", terminator: " ")
        }
        print()
    #endif
}

// 时间格式
let DAY_FORMAT = "yyyy-MM-dd"
let SECOND_FORMAT = "yyyy-MM-dd HH:mm:ss"


struct Constants {
    static let build = Bundle.build
    static let versionNumber = Bundle.versionNumber
}
