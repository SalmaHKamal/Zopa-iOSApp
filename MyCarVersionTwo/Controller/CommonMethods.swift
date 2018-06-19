//
//  CommonMethods.swift
//  MyCarVersionTwo
//
//  Created by Yasmin Ahmed on 6/16/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import Foundation
import UIKit

public class CommonMethods: NSObject {
    
    static var cars = [Car]()
    
    class func getloggedInUserId() -> String {
        let userDef = UserDefaults.standard
        print("user id \(userDef.value(forKey: "userId") as! String)")
        return userDef.value(forKey: "userId") as! String
    }
    

    class func showAlert(base: UIViewController, actions: [UIAlertAction], alertTitle: String, alertMsg: String) {
        
        let alert = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: UIAlertControllerStyle.alert)
        
        for action in actions {
            alert.addAction(action)
        }
        
        base.present(alert, animated: true, completion: nil)
    }
    
}
