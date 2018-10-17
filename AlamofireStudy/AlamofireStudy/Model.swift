//
//  Model.swift
//  AlamofireStudy
//
//  Created by 索晓晓 on 2018/10/15.
//  Copyright © 2018年 SXiao.RR. All rights reserved.
//

import Foundation
import ObjectMapper

struct Headers :Mappable{
    var accept: String!
    var accept_Encoding: String!
    var connection: String!
    var host: String!
    var user_Agent: String!
    var content_Length: String!
    var accept_Language: String!
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        accept <- map["Accept"]
        accept_Encoding <- map["Accept-Encoding"]
        host <- map["Host"]
        connection <- map["Connection"]
        user_Agent <- map["User-Agent"]
        content_Length <- map["Content-Length"]
        accept_Language <- map["Accept-Language"]
    }
}
struct Args :Mappable{
    init?( map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
    }
}
struct Files :Mappable{
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
    }
}
struct Form :Mappable{
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
    }
}

struct SX: Mappable {
    
    var origin: String!
    var json: String!
    var url: String!
    var data: String!
    var headers: Headers!
    var args: Args!
    var files: Files!
    var form: Form!
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        origin <- map["origin"]
        headers <- map["headers"]
        url <- map["url"]
        json <- map["json"]
        data <- map["data"]
        args <- map["args"]
        files <- map["files"]
        form <- map["form"]
    }
    
}



