//
//  Channel.swift
//  VMediaTest
//
//  Created by Heramb on 10/03/23.
//

import ObjectMapper

struct Channel: Mappable {
    
    var orderNum: Int?
    var accessNum: Int?
    var callSign: String?
    var id: Int?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        orderNum           <- map["orderNum"]
        accessNum          <- map["accessNum"]
        callSign           <- map["CallSign"]
        id                 <- map["id"]
    }
    
}

