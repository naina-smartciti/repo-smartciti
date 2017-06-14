//
//  User.swift
//  SmartCiti
//
//  Created by Sathish on 07/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import ObjectMapper

class User: NSObject, Mappable {
    
    var userId: Int?
    var email: String?
    var firstName: String?
    var password: String?
    var createdOn: String?
    var dob: String?
    var active: Bool?
    var deleted: Bool?
    var companyName: String?
    var businessName: String?
    var businessType: String? // Create event response param
    var profileImage: String?
    var phoneNumber: String?
    var facebookId: String?
    var lastName: String?
    var userType: UserType?
    var newPassword: String?
    var confirmPassword: String?
    var passwordForceUpdate: Bool?
    
    var userAccount: String?
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        userId <- map["userId"]
        email <- map["email"]
        firstName <- map["firstName"]
        password <- map["password"]
        createdOn <- map["createdOn"]
        dob <- map["dob"]
        active <- map["active"]
        deleted <- map["deleted"]
        companyName <- map["companyName"]
        businessName <- map["businessName"]
        businessType <- map["businessType"]
        profileImage <- map["profileImage"]
        phoneNumber <- map["phoneNumber"]
        facebookId <- map["facebook_id"]
        lastName <- map["lastName"]
        userType <- map["userType"]
        newPassword <- map["newPassword"]
        confirmPassword <- map["confirmPassword"]
        passwordForceUpdate <- map["passwordForceUpdate"]
        
        userAccount <- map["useraccount"]
    }
}

/*
 {
 "userId": 12,
 "email": "optisoltest123@gmail.com",
 "firstName": "optiosl",
 "password": "e10adc3949ba59abbe56e057f20f883e",
 "createdOn": "01-30-2017 17:15:13",
 "dob": "01-22-2006",
 "active": true,
 "deleted": false,
 "companyName": null,
 "businessName": null,
 "profileImage": null,
 "phoneNumber": null,
 "facebook_id": "d41d8cd98f00b204e9800998ecf8427e",
 "lastName": "test",
 "passwordForceUpdate": false,
 "userType": {
 "userTypeId": 1,
 "userTypeName": "personal",
 "authority": "personal"
 },
 "newPassword": null,
 "confirmPassword": null,
 "useraccount": false
 }
 */
