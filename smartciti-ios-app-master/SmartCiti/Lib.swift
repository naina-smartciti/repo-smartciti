//
//  Lib.swift
//  SmartCiti
//
//  Created by Sathish on 06/02/17.
//  Copyright © 2017 Optisol Business Solution. All rights reserved.
//

import Foundation
import ReachabilitySwift

class Lib: NSObject {
    
    class var sharedInstance: Lib {
        struct Static {
            static let instance = Lib()
        }
        return Static.instance
    }
    
    public func isHasConnection () -> Bool {
        let reachability = Reachability();
        if(reachability?.currentReachabilityStatus == Reachability.NetworkStatus.notReachable){
            return false;
        }
        return true;
    }
    
    func BottomBorder(txtFld: UITextField, bottomColor: UIColor){
        let border = CALayer()
        border.frame = CGRect(x:0, y:txtFld.frame.size.height - 3,width: txtFld.frame.size.width,height: 1)
        border.backgroundColor = bottomColor.cgColor
        txtFld.layer.addSublayer(border)
    }
    
}
