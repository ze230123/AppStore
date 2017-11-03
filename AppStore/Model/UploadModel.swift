//
//  UploadModel.swift
//  AppStore
//
//  Created by 泽i on 2017/10/31.
//  Copyright © 2017年 泽i. All rights reserved.
//

import ObjectMapper

struct UploadModel: Mappable {
    /// app名
    var name: String = ""
    /// 版本
    var version: String = ""
    /// 更新日志
    var changeLog: String = ""
    /// 更新时间
    var update: TimeInterval = 0
    /// 版本编号(兼容就字段)
    var versionShort: String = ""
    /// 编译号
    var build: String = ""
    /// 安装地址
    var installUrl: String = ""
    /// 更新地址
    var updateUrl: String = ""
    /// 更新文件大小
    var fsize: Int = 0

    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        name            <- map["name"]
        version         <- map["version"]
        changeLog       <- map["changelog"]
        update          <- map["updated_at"]
        versionShort    <- map["versionShort"]
        build           <- map["build"]
        installUrl      <- map["install_url"]
        updateUrl       <- map["update_url"]
        fsize           <- map["binary.fsize"]
    }
}
extension UploadModel {
    func isGreater(_ version: String) -> Bool {
        // 本地version
        let arrV1 = version.components(separatedBy: ".").flatMap { Int($0) }
        // 获取的version
        let arrV2 = versionShort.components(separatedBy: ".").flatMap { Int($0) }
        
        for (i, v1) in arrV1.enumerated() {
            print("v1: \(v1), v2: \(arrV2[i])")
            if v1 < arrV2[i] {
                return true
            }
        }
        if arrV1.count < arrV2.count {
            return true
        }
        return false
    }

}
/*
 {
 "name": "AppStore",
 "version": "1",
 "changelog": "创建",
 "updated_at": 1509451344,
 "versionShort": "1.0",
 "build": "1",
 "installUrl": "https://download.fir.im/v2/app/install/59f86639ca87a854000002a6?download_token=005aadf57a74787d544663c835bbf3d2\u0026source=update",
 "install_url": "https://download.fir.im/v2/app/install/59f86639ca87a854000002a6?download_token=005aadf57a74787d544663c835bbf3d2\u0026source=update",
 "direct_install_url": "",
 "update_url": "http://fir.im/j19x",
 "binary": {
 "fsize": 12987752
 }
 }
 */
