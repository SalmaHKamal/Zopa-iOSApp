//
//  CommonMethods.swift
//  MyCarVersionTwo
//
//  Created by Yasmin Ahmed on 6/16/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import Foundation

class CommonMethods: NSObject {
    
    static var cars = [Car]()
    
    class func getloggedInUserId() -> String {
        let userDef = UserDefaults.standard
        return userDef.value(forKey: "userId") as! String
    }
    
    class func getAllCarsForUser() -> [Car] {
        let userId = CommonMethods.getloggedInUserId()
        cars = CarDAO.getInstance().getAllCars(userID: userId)
        return cars
    }
    
}
