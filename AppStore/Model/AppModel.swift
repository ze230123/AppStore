//
//  AppModel.swift
//  AppStore
//
//  Created by 泽i on 2017/10/27.
//  Copyright © 2017年 泽i. All rights reserved.
//
import ObjectMapper

struct CustomAppModel: Codable {
    var bundleId: String
    var createdDate: TimeInterval
    var marketUrl: String
    var expiredDate: TimeInterval
    var iconUrl: String
    var id: String
    var name: String
    var short: String
    var type: String
    var updateDate: TimeInterval
    var userId: String
    var release: CustomReleaseModel

    enum CodingKeys: String, CodingKey {
        case bundleId = "bundle_id"
        case createdDate = "created_at"
        case marketUrl = "custom_market_url"
        case expiredDate = "expired_at"
        case iconUrl = "icon_url"
        case id
        case name
        case short
        case type
        case updateDate = "updated_at"
        case userId = "user_id"
        case release = "master_release"
    }
}

struct CustomReleaseModel: Codable {
    var build: String
    var createDate: TimeInterval
    var distributionName: String
    var version: String
    
    enum CodingKeys: String, CodingKey {
        case build
        case createDate = "created_at"
        case distributionName = "distribution_name"
        case version
    }
}

struct AppModel: Mappable {
    var bundleId: String = ""
    /// 创建日期
    var createdDate: TimeInterval = 0
    var marketUrl: String = ""
    /// 已到期
    var expiredDate: TimeInterval = 0
    /// 图标URL
    var iconUrl: String = ""
    var id: String = ""
    var isOpened: Int = 0
    var name: String = ""
    var orgid: String = ""
    var short: String = ""
    var type: String = ""
    var updateDate: TimeInterval = 0
    var userId: String = ""
    var release: ReleaseModel = ReleaseModel()
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        bundleId    <- map["bundle_id"]
        createdDate     <- map["created_at"]
        marketUrl       <- map["custom_market_url"]
        expiredDate     <- map["expired_at"]
        iconUrl         <- map["icon_url"]
        id              <- map["id"]
        isOpened        <- map["is_opened"]
        release         <- map["master_release"]
        name            <- map["name"]
        orgid           <- map["org_id"]
        short           <- map["short"]
        type            <- map["type"]
        updateDate      <- map["updated_at"]
        userId          <- map["user_id"]
    }
}

struct ReleaseModel: Mappable {
    var build: Int = 0
    var createDate: TimeInterval = 0
    var distributionName: String = ""
    var version: String = ""
    init() {

    }
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        build   <- map["build"]
        createDate <- map["created_at"]
        distributionName <- map["distribution_name"]
        version <- map["version"]
    }
}
