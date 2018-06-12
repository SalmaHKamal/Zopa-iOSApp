//
//  Oil.swift
//  MyCarVersionTwo
//
//  Created by Yasmin Ahmed on 5/31/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import RealmSwift

class Oil: Object {

    @objc dynamic var type = "";
    @objc dynamic var numOfKm = 0.0;
    @objc dynamic var price = 0.0;
    @objc dynamic var date = Date();
    @objc dynamic var carId = ""
    
    convenience init (oilTypeVal: String, numOfKmVal: Double, oilPriceVal: Double, dateVal: Date , carIdVal : String) {
        
        self.init();
        self.type = oilTypeVal;
        self.numOfKm = numOfKmVal;
        self.price = oilPriceVal;
        self.date = dateVal;
        self.carId = carIdVal
    }
}
