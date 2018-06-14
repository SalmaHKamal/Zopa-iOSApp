//
//  Refuel.swift
//  MyCarVersionTwo
//
//  Created by Yasmin Ahmed on 5/31/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import RealmSwift

class Refuel: Object {

    @objc dynamic var type = "";
    @objc dynamic var date = Date();
    @objc dynamic var price = 0.0;
    @objc dynamic var place = "";
    @objc dynamic var extraNotes = "";
    @objc dynamic var amount = 0.0;
    
    convenience init (refuelingTypeVal: String, refuelingDateVal: Date, refuelingPriceVal: Double, refuelingPlaceVal: String, extraNotesVal: String, refuelAmount: Double) {
        
        self.init();
        self.type = refuelingTypeVal;
        self.date = refuelingDateVal;
        self.price = refuelingPriceVal;
        self.place = refuelingPlaceVal;
        self.extraNotes = extraNotesVal;
        self.amount = refuelAmount;
    }
}
