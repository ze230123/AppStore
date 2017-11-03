//
//  Double+Extension.swift
//  RentPhone
//
//  Created by 泽i on 2017/10/26.
//  Copyright © 2017年 泽i. All rights reserved.
//

extension Double {
    /// 时间数字格式化
    var dateFormatter: String {
        return APPCenter.dateFormatter.string(from: Date(timeIntervalSince1970: self))
    }
}
