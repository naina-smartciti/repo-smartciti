//
//  UserDetail.swift
//  SmartCiti
//
//  Created by Sathish on 09/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import ObjectMapper

class UserDetail: NSObject, Mappable {
    
    var accessToken: String?
    var tokenType: String?
    var refreshToken: String?
    var scope: String?
    var user: User?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        accessToken <- map["access_token"]
        tokenType <- map["token_type"]
        refreshToken <- map["refresh_token"]
        scope <- map["scope"]
        user <- map["User"]
    }
}
