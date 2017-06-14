//
//  Entity.swift
//  SmartCiti
//
//  Created by Sathish on 15/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import ObjectMapper

class Entity: NSObject, Mappable {
    
    var userID: Int?
    var email: String?
    var firstName: String?
    var password: String?
    var createdOn: String?
    var dateOfBirth: String?
    var active: String?
    var deleted: String?
    var companyName: String?
    var businessName: String?
    var profileImage: String?
    var phoneNumber: String?
    var facebookId: String?
    var lastName: String?
    var passwordForceUpdate: Bool?
    var userType: UserType?
    var newPassword: String?
    var confirmPassword: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map) {
        userID <- map["userId"]
        email <- map["email"]
        firstName <- map["firstName"]
        password <- map["password"]
        createdOn <- map["createdOn"]
        dateOfBirth <- map["dob"]
        active <- map["active"]
        deleted <- map["deleted"]
        companyName <- map["companyName"]
        businessName <- map["businessName"]
        profileImage <- map["profileImage"]
        phoneNumber <- map["phoneNumber"]
        facebookId <- map["facebook_id"]
        lastName <- map["lastName"]
        passwordForceUpdate <- map["passwordForceUpdate"]
        userType <- map["userType"]
        newPassword <- map["newPassword"]
        confirmPassword <- map["confirmPassword"]
    }
}
