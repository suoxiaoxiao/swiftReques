//
//  ViewController.swift
//  AlamofireStudy
//
//  Created by 索晓晓 on 2018/10/11.
//  Copyright © 2018年 SXiao.RR. All rights reserved.
//

import UIKit
import Alamofire
import Moya
import SwiftyJSON
import ObjectMapper

enum RequestType {
    case testRequest
}

extension RequestType: TargetType{
    var baseURL: URL {
        return URL(string: "https://httpbin.org")!
    }
    
    var path: String {
        return "post"
    }
    
    var method: Moya.Method {
        switch self {
        case .testRequest:
            return .post
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["" : ""]
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        HTTPRequest.POST(params: nil, success: { (result) in
//
//            print(result)
//
//        }) { (error) in
//
//        }
        
        let target = RequestType.testRequest
        
        let test = MoyaProvider<RequestType>()
        
        test.request(target) { (result) in
            
            switch result {
            case let .success(response):
                
                do{
                    
                    let jsonValue = try JSON(data: response.data)
                    let jsonstring = jsonValue.rawString(String.Encoding.utf8, options: JSONSerialization.WritingOptions.prettyPrinted)
                    let obj = Mapper<SX>().map(JSONString:  jsonstring!)
                    print(obj!.headers.host!)
                    
                }catch{
                }
                
                break
            case let .failure(error):
                print(error)
                print("网络连接失败")
                break
            }
            
        }
        
//        let target = RequestType.testRequest
//
//        let test = MoyaProvider<RequestType>()
//
//        test.request(target) { (result) in
//
//            switch result {
//            case let .success(response):
//                do{
//
//                    //不使用SwiftyJSON进行json解析
//                    //                    let jsonValue = try? JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any]
//
//                    //                    let head = jsonValue?!["headers"] as? [String: Any]
//                    //                    let host = head?["Host"] as? String
//
//                    //                    print(host ?? "")
//
//                    //使用SwiftyJSON
//                    let jsonValue =  try JSON(data: response.data)
//                    print(jsonValue)
//
//                    if let Host = jsonValue["headers"]["Host"].string {
//                        print(Host)
//                    }
//
//                    //使用ObjectMapper转换模型
//                    let jsonstring = jsonValue.rawString(String.Encoding.utf8, options: JSONSerialization.WritingOptions.prettyPrinted)
//                    let obj = Mapper<SX>().map(JSONString:  jsonstring!)
//                    print(obj!.headers.host!)
//
//                }catch{
//                }
//                break
//            case let .failure(error):
//                print(error)
//                print("网络连接失败")
//                break
//            }
//
//        }
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    

}


class User: Mappable {
    
    func mapping(map: Map) {
        name <- map["name"]
    }
    
    var name: String?
    
    required init?(map: Map) {
    }
    
}

class Result<T: Mappable>: Mappable {
    var result: T?
    
    required init?( map: Map){
        
    }
    
    func mapping(map: Map) {
        result <- map["result"]
    }
}


func test()->Void{
    HTTPRequest.POST(params: nil, success: { (result) in
        
        print(result)
        //这边获取的是字典, 如何将字典自动转化为模型 用mapper?
        
        
        
    }) { (error) in
        
    }
}

