//
//  ListModel.swift
//  AppStore
//
//  Created by 泽i on 2017/10/27.
//  Copyright © 2017年 泽i. All rights reserved.
//

import ObjectMapper

struct ListModel<M: Mappable>: Mappable {
    var count: Int = 0
    var pageSize: Int = 0
    var items: [M] = []

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        count       <- map["apps_count"]
        pageSize    <- map["page_size"]
        items       <- map["items"]
    }
}

struct CustomListModel<M: Codable>: Codable {
    var count: Int
    var pageSize: Int
    var items: [M]

    enum CodingKeys: String, CodingKey {
        case count = "apps_count"
        case pageSize = "page_size"
        case items
    }
}
