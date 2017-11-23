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

    static func getCustom<T: Codable>(url: URLConvertible, parameters: [String: Any]? = nil) -> Promise<T> {
        return Promise<T> { fulfill, reject in
            Alamofire.request(url, method: .get, parameters: parameters).responseData { (response) in
                switch response.result {
                case let .success(data):
                    print(String(data: data, encoding: .utf8) ?? "没有数据")
                    do {
                        let model = try JSONDecoder().decode(T.self, from: data)
                        fulfill(model)
                    } catch {
                        // 异常处理
                        printLog(error.localizedDescription)
                        reject(error)
                    }
                case let .failure(error):
                    reject(error)
                }
            }
        }
    }

    static func getCustomList<T: Codable>(url: URLConvertible, parameters: [String: Any]? = nil) -> Promise<CustomListModel<T>> {
        return Promise<CustomListModel<T>> { fulfill, reject in
            getCustom(url: url, parameters: parameters).then(execute: { (model: CustomListModel<T>) -> Void in

                fulfill(model)
            }).catch(execute: { (error) in
                reject(error)
            })
        }
    }
}
