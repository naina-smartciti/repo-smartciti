//
//  EventEntity.swift
//  SmartCiti
//
//  Created by Sathish on 23/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import ObjectMapper

class EventEntity: NSObject, Mappable {
    
    var eventId: Int?
    var eventName: String?
    var eventType: String?
    var eventDescription: String?
    var startDate: String?
    var endDate: String?
    var startTime: String?
    var endTime: String?
    var location: String?
    var latitude: String?
    var longitude: String?
    var image: String?
    var active: Bool?
    var deleted: Bool?
    var user: User?
    var favorites: Bool?
    var likeCount: Int?
    var dislikeCount: Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        eventId <- map["eventid"]
        eventName <- map["eventName"]
        eventType <- map["event_type"]
        eventDescription <- map["event_description"]
        startDate <- map["start_date"]
        endDate <- map["end_date"]
        startTime <- map["start_time"]
        endTime <- map["end_time"]
        location <- map["location"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        image <- map["image"]
        active <- map["active"]
        deleted <- map["deleted"]
        user <- map["user"]
        favorites <- map["favourite"]
        likeCount <- map["likesount"]
        dislikeCount <- map["dislikecount"]
        
    }
}
