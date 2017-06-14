//
//  BusinessEntity.swift
//  SmartCiti
//
//  Created by Sathish on 23/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import ObjectMapper

class BusinessEntity: NSObject, Mappable {
    
    var businessId: Int?
    var businessName: String?
    var websiteURL: String?
    var phoneNumber: String?
    var category: String?
    var businessDescription: String?
    var businessLocation: String?
    var latitude: String?
    var longitude: String?
    var active: Bool?
    var businessImage: String?
    var categoryId: CategoryID?
    var userId: User?
    var hourseOfOperation: [HourseOfOperation]?
    var parkingLocation: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        businessId <- map["business_id"]
        businessName <- map["business_name"]
        websiteURL <- map["website_URL"]
        phoneNumber <- map["phone_number"]
        category <- map["category"]
        businessDescription <- map["description"]
        businessLocation <- map["business_location"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        active <- map["active"]
        businessImage <- map["business_image"]
        categoryId <- map["category_id"]
        userId <- map["user_id"]
        hourseOfOperation <- map["hoursOfOperation"]
        parkingLocation <- map["parking_location"]
    }
}
