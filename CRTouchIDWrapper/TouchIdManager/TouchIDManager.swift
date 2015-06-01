//
//  TouchIDManager.swift
//  CRTouchIDWrapper
//
//  Created by CheeseRoot on 01/06/15.
//  Copyright (c) 2015 CheeseRoot. All rights reserved.
//

import UIKit
import LocalAuthentication

@objc class TouchIDManager: NSObject {
    
    /*
    context -
    An instance of LAContext
    Should be initialized only if system version is greater than 8.0
    */
    var context:LAContext? {
        let iosVersion = UIDevice.currentDevice().systemVersion
        
        switch iosVersion.compare("8.0.0", options: NSStringCompareOptions.NumericSearch)
        {
        case .OrderedSame, .OrderedDescending:
            return LAContext()
        case .OrderedAscending:
            return nil
        }
    }
    
    
    /*
    LocalizedReason -
    Reason to use TouchID
    */
    var localizedReason:String?
    
    
    /*
    LocalizedFallbackTitle -
    Fallback button title in case touchID fails to detect fingerprint.
    Empty string for no fallback button.
    */
    var localizedFallbackTitle:String?
    
    
    /*
    Checks if touchID is available in iPhone
    And if available, is user enrolled.
    */
    func isTouchIdAvailableAndEnrolled() -> Bool
    {
        var error:NSError?
        let touchAvailability = context?.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error)
        
        if let availability = touchAvailability {
            return availability
        }
        else {
            return false
        }
    }
    
    
    /*
    Authenticates user
    Uses a completion block for handling after authentication is done.
    /*
    Completion block - (AuthSuccess, Error)
    */
    */
    class func presentTouchIdOptionForAuth(localizedReason:String, localizedFallbackTitle: String, completion: ((isAuthSuccess:Bool, error:NSError!) -> Void)!)
    {
        var isSuccess = true
        let myClassObj = TouchIDManager()
        
        if myClassObj.isTouchIdAvailableAndEnrolled() {
            myClassObj.context?.localizedFallbackTitle = localizedFallbackTitle
            myClassObj.context?.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: localizedReason, reply: { (success, authenticationError) -> Void in
                isSuccess = success
                completion(isAuthSuccess: isSuccess, error: authenticationError)
            })
        }
        else {
            completion(isAuthSuccess: isSuccess, error: nil)
        }
    }
}
