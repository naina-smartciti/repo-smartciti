//
//  AddLikeEntity.swift
//  SmartCiti
//
//  Created by Sathish on 23/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import ObjectMapper

class AddLikeEntity: NSObject, Mappable {
    
    
    var likeId: Int?
    var active: Bool?
    var user: User?
    var event: EventEntity?
    var createdOn: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        likeId <- map["like_id"]
        active <- map["active"]
        user <- map["user"]
        event <- map["event"]
        createdOn <- map["createdOn"]
    }
}
