//
//  FavoriteEntity.swift
//  SmartCiti
//
//  Created by Sathish on 23/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import ObjectMapper

class FavoriteEntity: NSObject, Mappable {
    
    var favoriteId: Int?
    var active: Bool?
    var user: User?
    var event: EventEntity?
    var createdOn: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        favoriteId <- map["favourtie_id"]
        active <- map["active"]
        user <- map["user"]
        event <- map["event"]
        createdOn <- map["createdOn"]
    }
}
