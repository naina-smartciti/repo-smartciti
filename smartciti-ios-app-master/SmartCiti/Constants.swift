//
//  Constants.swift
//  SmartCiti
//
//  Created by Sathish on 06/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
public struct Constants {
    
    // Base toke
    public let kBaseToken = "Basic c21hcnRjaXR5OnNtYXJ0Y2l0eQ=="
    
    // DOMAIN NAME
    public let kBaseURL = "http://35.167.31.23:8080/smartcity"
    
    // API ENDPOINT EXTENDED:
    public let kLoginURL = "/oauth/token"
    public let kRegisterURL = "/register"
    public let kFacebookLoginURL = "/facebooklogin"
    public let kForgotPasswordURL = "/forgotpassword"
    public let kChangePasswordURL = "/changepassword"
    public let kCategoryList = "/getcategorylist"
    public let kViewProfileURL = "/viewProfile"
    
    //MARK: -UserDefaults
    public let kTokenUserdafult = "user_auth_token"
    
    // MARK: - Alert Messages
    public let kLoginFailedMsg = "Login Failed!, username/password mismatch."
    public let kAlertTitle = "Alert"
    public let kRegistationFail = "Registration Failure"
    
    //MARK: - Controllers
    public let kStoryBoardMain = "Main"
    
    //MARK: - Cells
    public let kBlockCellIdentifier = "BlockCellIdentifier"
    
    //MARK: - Strings
    public let kTitle = "Title"
    
    // MARK: - Storyboard ID
    public let kForgetPassword = "ForgetPasswordViewController"
    public let kChangePassword = "ChangePasswordViewController"
    public let kTabBarSB = "TabBarViewController"
    public let kFilterSB = "FilterViewController"
    public let kSettingSB = "SettingViewController"
    public let kRegisterSB = "RegisterViewController" // Create view controller
    public let kCreateAccountSB = ""
    public let kHomeSB = "HomeViewController"
    public let kLoginSB = "loginViewController"
    public let kAccountDetailsSB = "accountDetailsSB"
    
    // MARK: - Cell Reuse identifier
    public let kfilterCell = "filterCollectionCell"
    public let kHomeCell = "HomeTableViewCell"
}
