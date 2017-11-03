////
////  Serviceor.swift
////  AppStore
////
////  Created by 泽i on 2017/10/27.
////  Copyright © 2017年 泽i. All rights reserved.
////
//
////
////  Service.swift
////  DaDaXTStuMo
////
////  Created by 黄伯驹 on 2017/8/10.
////  Copyright © 2017年 dadaabc. All rights reserved.
////
//
//import Alamofire
//import ObjectMapper
//import PromiseKit
//
//enum AnalyzeError: Error {
//    case analyze
//    case codeError
//    case commonError(String)
//}
//
//struct Servicer {
//
//    // method defaults to `.post`
//    static func request<T: ModelObject>(
//        _ url: URLConvertible,
//        method: HTTPMethod = .post,
//        parameters: Parameters? = nil,
//        encoding: ParameterEncoding = URLEncoding.default,
//        headers: HTTPHeaders? = nil) -> Promise<T> {
//
//        return Promise<T> { fulfill, reject in
//            excute(url, method: method, parameters: parameters, encoding: encoding, headers: headers).then { json -> Void in
//                if let model = Mapper<T>().map(JSON: json) {
//                    fulfill(model)
//                } else {
//                    reject(AnalyzeError.analyze)
//                    assert(false, "❌❌❌ 解析错误")
//                }
//                }.catch(execute: { (error) in
//                    reject(error)
//                })
//        }
//    }
//
//    static func requestList<T: ModelObject>(
//        _ url: URLConvertible,
//        method: HTTPMethod = .post,
//        parameters: Parameters? = nil,
//        encoding: ParameterEncoding = URLEncoding.default,
//        headers: HTTPHeaders? = nil) -> Promise<[T]> {
//        return Promise<[T]> { fulfill, reject in
//            request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).then { (model: ListModel<T>) -> Void in
//                if model.code == 1 {
//                    fulfill(model.data)
//                } else {
//                    reject(AnalyzeError.commonError(model.message))
//                }
//                }.catch(execute: { (error) in
//                    reject(error)
//                })
//        }
//    }
//
//    // method defaults to `.post`
//    static func requestDetial<T: ModelObject>(
//        _ url: URLConvertible,
//        method: HTTPMethod = .post,
//        parameters: Parameters? = nil,
//        encoding: ParameterEncoding = URLEncoding.default,
//        headers: HTTPHeaders? = nil) -> Promise<T> {
//        return Promise<T> { fulfill, reject in
//            request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).then { (model: CommonModel<T>) -> Void in
//                if model.code == 1 {
//                    fulfill(model.data)
//                } else {
//                    reject(AnalyzeError.commonError(model.message))
//                }
//                }.catch(execute: { (error) in
//                    reject(error)
//                })
//        }
//    }
//
//    static func excute(
//        _ url: URLConvertible,
//        method: HTTPMethod = .post,
//        parameters: Parameters? = nil,
//        encoding: ParameterEncoding = URLEncoding.default,
//        headers: HTTPHeaders? = nil) -> Promise<[String: Any]> {
//
//        print("📶📶📶", url)
//
//        return Promise<[String: Any]> { fulfill, reject in
//            Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { (response) in
//                switch response.result {
//                case let .success(str):
//                    print("✅✅✅", response.response?.url as Any)
//                    if let dict = str as? [String: Any] {
//                        fulfill(dict)
//                    } else {
//                        assert(false, "❌❌❌ 数据错误")
//                    }
//                case let .failure(error):
//                    print("❌❌❌", error, response.response?.url as Any)
//                    reject(error)
//                }
//            }
//        }
//    }
//
//    static func download() {
//
//    }
//
//    static func upload<T: ModelObject>(_ data: Data, to path: String = "upload", fileName: String, headers: [String: String]) -> Promise<T> {
//        return Promise<T> { fulfill, reject in
//            Alamofire.upload(multipartFormData: { multipartFormData in
//                for (key, value) in headers {
//                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
//                }
//                multipartFormData.append(data, withName: "file", fileName: "\(fileName)_dadaxt.jpeg", mimeType: "image/jpeg")
//            }, to: UPLOAD_PATH + "/" + path, encodingCompletion: { encodingResult in
//                switch encodingResult {
//                case .success(let upload, _, _):
//                    upload.responseJSON { response in
//                        switch response.result {
//                        case let .success(json):
//                            print("✅✅✅", response.response?.url as Any)
//                            if let data = Mapper<T>().map(JSONObject: json) {
//                                fulfill(data)
//                            } else {
//                                reject(AnalyzeError.analyze)
//                                assert(false, "❌❌❌ 解析错误")
//                            }
//                        case let .failure(error):
//                            print("❌❌❌", error, response.response?.url as Any)
//                            reject(error)
//                        }
//                    }
//                    print("✅✅✅")
//                case .failure(let error):
//                    print("❌❌❌", error)
//                    reject(error)
//                }
//            })
//        }
//    }
//}
//
