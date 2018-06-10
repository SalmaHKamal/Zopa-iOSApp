//
//  Validator.swift
//  MyCarVersionTwo
//
//  Created by Sayed Abdo on 6/6/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit

class Validator: NSObject {
    
    class func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    static func showAlert(withTitle:String, message:String, viewController:UIViewController) {
        let alertController = UIAlertController(title: withTitle, message: message, preferredStyle: UIAlertControllerStyle.alert) //Replace
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            
            
        }
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
        
    }
    
}
