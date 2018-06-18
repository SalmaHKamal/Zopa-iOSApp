//
//  CommonMethods.swift
//  MyCarVersionTwo
//
//  Created by Yasmin Ahmed on 6/16/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import Foundation

public class CommonMethods: NSObject {
    
    static var cars = [Car]()
    
    class func getloggedInUserId() -> String {
        let userDef = UserDefaults.standard
        print("user id \(userDef.value(forKey: "userId") as! String)")
        return userDef.value(forKey: "userId") as! String
    }
    
    class func getAllCarsForUser() -> [Car] {
        let userId = CommonMethods.getloggedInUserId()
        let user = UserDAO.getInstance().getUserByID(userId: userId)
        cars = Array((user?.cars)!)
//        cars = CarDAO.getInstance().getAllCars(userID: userId)
        print("cars count\(cars.count)")
        return cars
    }
    
}
