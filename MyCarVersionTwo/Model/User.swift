//
//  User.swift
//  MyCarVersionTwo
//
//  Created by Yasmin Ahmed on 5/31/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import RealmSwift

class User: Object {
    @objc dynamic var id = UUID().uuidString;
    @objc dynamic var name = "";
    @objc dynamic var email = "";
    @objc dynamic var password = "";
    @objc dynamic var gender = "";
    @objc dynamic var mobile = "";
    @objc dynamic var address = "";
    @objc dynamic var profilePic : Data = Data();
    var cars = List <Car>();
    
    override static func primaryKey() -> String? {
        return "id";
    }
    
    convenience init (userNameVal: String, userEmailVal: String, userPasswordVal: String, userGenderVal: String, userMobVal: String , userPicVal : Data, address : String) {
        
        self.init();
        self.name = userNameVal;
        self.email = userEmailVal;
        self.password = userPasswordVal;
        self.gender = userGenderVal;
        self.mobile = userMobVal;
        self.profilePic = userPicVal
        self.address = address
        
    }
    
}
