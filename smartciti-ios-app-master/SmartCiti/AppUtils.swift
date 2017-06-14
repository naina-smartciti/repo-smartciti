//
//  ApUtil.swift
//  SmartCiti
//
//  Created by Sathish on 06/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class AppUtils: NSObject {
    
    class var sharedInstance: AppUtils {
        struct Static {
            static let instance = AppUtils()
        }
        return Static.instance
    }
    
    // Verify email
    public func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    // Simple alert
    public func simpleAlert(view:UIViewController, title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
    
    // Show hub loader
    func hubShow() {
        
    }
    
    
    // Hide hud loader
    func hudHider() {
        
    }
    
}
