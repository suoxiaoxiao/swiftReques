//
//  HTTPRequest.swift
//  AlamofireStudy
//
//  Created by 索晓晓 on 2018/10/11.
//  Copyright © 2018年 SXiao.RR. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class HTTPRequest: NSObject {
    
    let header:HTTPHeaders = ["":""]
    
    override init() {
        super.init()
    }
    
    
    
    
    
    
    
    
    
    
    class func POST(params: Parameters?, success: @escaping (Dictionary<String, Any>)->Void,fail:@escaping (Error?)->Void){
        
        let param:Parameters = params ?? Parameters();
        
        
        
        Alamofire.request("https://httpbin.org/post",
                          method: .post,
                          parameters: param).responseObject { (response: DataResponse<SX>) in
            
            let result = response.result.value
            
            print(result!.headers.host)
            
        }
        
//        Alamofire.request("https://httpbin.org/post",
//                          method: .post,
//                          parameters: param).responseData(queue: DispatchQueue.main, completionHandler: { (response) in
//
//                            if let data = response.data {
//
//                                do{
//                                    let result = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
//
//                                    success(result as! Dictionary)
//
//                                }catch let error {
//
//                                    fail( error as Error )
//                                }
//
//                            }else{
//                                fail(nil)
//                            }
//                          })
        }
    
}



