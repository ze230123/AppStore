//
//  Singleton.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/21.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

/// 格式化操作实例 如：时间，金钱
let APPCenter = Singleton.shared

/// 格式化操作的类 如：时间，金钱
class Singleton {
    static let shared = Singleton()

    // 这个有比较耗性能，所以坐在单列里面
    lazy var dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = SECOND_FORMAT
        return f
    }()

    lazy var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.positiveFormat = "###,###.00"
        return numberFormatter
    }()

    private init() {}
}
