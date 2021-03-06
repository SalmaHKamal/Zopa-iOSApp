//
//  Car.swift
//  MyCarVersionTwo
//
//  Created by Yasmin Ahmed on 5/31/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import RealmSwift

class Car: Object {

    @objc dynamic var id = UUID().uuidString;
    @objc dynamic var name = "";
    @objc dynamic var model = "";
    @objc dynamic var year = "";
    @objc dynamic var desc = "";
    @objc dynamic var image : Data = Data()
   // @objc dynamic var owner = ""
    
    var prevCarWashings = List <CarWash>();
    var prevRefuels = List <Refuel>();
    var prevOils = List <Oil>();
    
    override static func primaryKey() -> String? {
        return "id";
    }
    
    convenience init (carNameVal: String, carModelVal: String, carYearVal: String, carDescVal: String) {
        
        self.init();
        self.name = carNameVal;
        self.model = carModelVal;
        self.year = carYearVal;
        self.desc = carDescVal;
       // self.owner = carOwnerVal;
    }
}
