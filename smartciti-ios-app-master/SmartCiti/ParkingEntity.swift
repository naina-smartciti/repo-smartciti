//
//  ParkingEntity.swift
//  SmartCiti
//
//  Created by Sathish on 23/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import ObjectMapper

class ParkingEntity: NSObject, Mappable {
    
    var parkingId: Int?
    var parkingName: String?
    var parkingLocation: String?
    var phoneNumber: String?
    var parkingWebSite: String?
    var parkingCapacity: String?
    var latitude: String?
    var longitude: String?
    var active: Bool?
    var business: String?
    var user: User?
    var parkingPriceDetails: [ParkingPriceDetail]?
    var userType: String?
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        parkingId <- map["parking_id"]
        parkingName <- map["parking_name"]
        parkingLocation <- map["parking_location"]
        phoneNumber <- map["phone_number"]
        parkingWebSite <- map["parking_web_site"]
        parkingCapacity <- map["parking_capacity"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        active <- map["active"]
        business <- map["business"]
        user <- map["user"]
        parkingPriceDetails <- map["parkingPriceDetails"]
        userType <- map["userType"]
    }
}
