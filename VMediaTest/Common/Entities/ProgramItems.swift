//
//  ProgramItems.swift
//  VMediaTest
//
//  Created by Heramb on 10/03/23.
//

import ObjectMapper

// MARK: - ProgramItem
struct ProgramItem: Mappable {
    var startTime: Date?
    var recentAirTime: RecentAirTime?
    var length: Int?
    var name: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        startTime          <- map["startTime"]
        recentAirTime      <- map["recentAirTime"]
        length             <- map["length"]
        name               <- map["name"]
    }
}

// MARK: - RecentAirTime
struct RecentAirTime: Mappable {
    var id, channelID: Int?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id             <- map["id"]
        channelID      <- map["channelID"]
    }
}

