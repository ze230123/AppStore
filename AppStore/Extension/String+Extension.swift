//
//  String+Extension.swift
//  AppStore
//
//  Created by 泽i on 2017/10/30.
//  Copyright © 2017年 泽i. All rights reserved.
//

extension String {
    var encode: String {
        let customAllowedSet = CharacterSet(charactersIn: ":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`").inverted
        return addingPercentEncoding(withAllowedCharacters: customAllowedSet) ?? ""
    }
}
