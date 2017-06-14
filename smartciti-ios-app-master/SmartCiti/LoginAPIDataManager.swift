//
//  LoginAPIDataManager.swift
//  SmartCiti
//
//  Created by Sathish on 09/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class LoginAPIDataManager: NSObject {
    
    class var sharedInstance: LoginAPIDataManager {
        struct Static {
            static let instance = LoginAPIDataManager()
        }
        return Static.instance
    }
    
    //private var userDetail: UserDetail = UserDetail()
    
    /*
     // User object
     private var user: User = User();
     
     //Login User
     public func loginUser(url: String, parameters: Parameters, view: UIView, completion:@escaping (_ user: User, _ statusCode: Int, _ token: Dictionary<String, String>) ->Void) -> Void{
     
     ServiceManager.sharedInstance.executeGetURL(url: url, params: parameters, view: view, completion:{response -> Void in
     let token = response.result.value!
     if response.result.isSuccess {
     print("login successful")
     print("\(token)")
     completion(self.user,(response.response?.statusCode)!, token as! Dictionary);
     } else {
     if let statusCode = response.response?.statusCode {
     print("login failed with status code: \(statusCode)")
     completion(self.user,statusCode, token as! Dictionary);
     }
     }
     });
     }
 */
    let device: Device = Device()
    // Login User
    public func loginUser(url: String, parameters: Parameters, view: UIView, headers: HTTPHeaders ,completion: @escaping(_ device: Device, _ statusCode: Int, _ responseValue: Any) -> Void) -> Void{

        ServiceManager.sharedInstance.executePostObjectURL(type: Device.self, url: url, params: parameters, headers: headers, view: view, completion: {
            response ->  Void in
            if (response?.result.isSuccess)! {
                print("login successful")
                print((response?.result.value)!)
                completion(self.device, (response?.response?.statusCode)! , response?.result.value as Any)
            } else if (response?.result.isFailure)! {
                print(response?.result.value as Any)
                print("response result failure")
            }
            print(response?.result.value as Any)
        })
//        ServiceManager.sharedInstance.executePostURL(url: url, params: parameters, view: view, headers: headers  ,completion: {
//            response -> Void in
//            let respValue = response.result.value
//            if (response.result.isSuccess) {
//                print("login successful")
//                print(respValue!)
//                
//                completion(self.device, (response.response?.statusCode)! , respValue)
//            } else if (response.result.isFailure) {
//                print(response.result.value)
//                print("response result failure")
//            }
//        })
//    }
    
}
}
