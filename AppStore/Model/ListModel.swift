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
