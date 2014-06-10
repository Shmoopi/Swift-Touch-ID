//
//  MainViewController.swift
//  SwiftTouchIDExample
//  Test the LocalAuthentication Framework in Swift
//
//  Created by Shmoopi on 6/6/14.
//  Copyright (c) 2014 Shmoopi LLC. All rights reserved.
//

import UIKit
import LocalAuthentication

class MainViewController: UIViewController {
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        // Custom initialization
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // Test the local authentication framework
    @IBAction func testTouchID(sender : AnyObject) {
        
        // Create an alert
        var alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        // Add the cancel button to the alert
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        // Create the Local Authentication Context
        var touchIDContext = LAContext()
        var touchIDError : NSError?
        var reasonString = "Local Authentication Testing"
        
        // Check if we can access local device authentication
        if touchIDContext.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error:&touchIDError) {
            // Check what the authentication response was
            touchIDContext.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: {
                (success: Bool, error: NSError?) -> Void in
                // Check if we passed or failed
                if success {
                    // User authenticated using Local Device Authentication Successfully!
                    
                    // Show a success alert
                    alert.title = "Success!"
                    alert.message = "You have authenticated!"
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                } else {
                    // Unsuccessful
                    
                    // Set the title of the unsuccessful alert
                    alert.title = "Unsuccessful!"
                    
                    // Set the message of the alert
                    switch error!.code {
                    case LAError.UserCancel.toRaw():
                        alert.message = "User Cancelled"
                    case LAError.AuthenticationFailed.toRaw():
                        alert.message = "Authentication Failed"
                    case LAError.PasscodeNotSet.toRaw():
                        alert.message = "Passcode Not Set"
                    case LAError.SystemCancel.toRaw():
                        alert.message = "System Cancelled"
                    case LAError.UserFallback.toRaw():
                        alert.message = "User chose to try a password"
                    default:
                        alert.message = "Unable to Authenticate!"
                    }
                    
                    // Show the alert
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                })
        } else {
            // Unable to access local device authentication
            
            // Set the error title
            alert.title = "Error"
            
            // Set the error alert message with more information
            switch touchIDError!.code {
            case LAError.TouchIDNotEnrolled.toRaw():
                alert.message = "Touch ID is not enrolled"
            case LAError.TouchIDNotAvailable.toRaw():
                alert.message = "Touch ID not available"
            case LAError.PasscodeNotSet.toRaw():
                alert.message = "Passcode has not been set"
            default:
                alert.message = "Local Authentication not available"
            }
            
            // Show the alert
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
