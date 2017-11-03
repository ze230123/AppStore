//
//  DownloadMdoel.swift
//  AppStore
//
//  Created by 泽i on 2017/10/27.
//  Copyright © 2017年 泽i. All rights reserved.
//

import ObjectMapper

struct DownloadModel: Mappable {
    var downloadToken: String = ""
    init?(map: Map) {

    }
    mutating func mapping(map: Map) {
        downloadToken   <- map["download_token"]
    }
}

extension DownloadModel {
    public func downloadUrl(id: String) -> String {
        let url = "https://download.fir.im/apps/\(id)/install?download_token=\(downloadToken)"
        return "itms-services://?action=download-manifest&url=\(url.encode)"
    }
}
