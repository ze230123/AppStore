//
//  Service.swift
//  AppStore
//
//  Created by 泽i on 2017/10/27.
//  Copyright © 2017年 泽i. All rights reserved.
//
import Alamofire
import ObjectMapper
import PromiseKit

struct Service {
    static func get<T: Mappable>(url: URLConvertible, parameters: [String: Any]? = nil) -> Promise<T> {
        return Promise<T> { fulfill, reject in
            Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
                switch response.result {
                case let .success(json):
                    print(json)
                    if let model = Mapper<T>().map(JSON: json as! [String : Any]) {
                        fulfill(model)
                    }
                case let .failure(error):
                    reject(error)
                }
            }
        }
    }

    static func getList<T: Mappable>(url: URLConvertible, parameters: [String: Any]? = nil) -> Promise<ListModel<T>> {
        return Promise<ListModel<T>> { fulfill, reject in
            get(url: url, parameters: parameters).then(execute: { (model: ListModel<T>) -> Void in
                fulfill(model)
            }).catch(execute: { (error) in
                reject(error)
            })
        }
    }
}
