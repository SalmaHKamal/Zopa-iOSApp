//
//  UserDAO.swift
//  MyCarVersionTwo
//
//  Created by Yasmin Ahmed on 5/31/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import RealmSwift

class UserDAO: NSObject {

    private static let userInstance = UserDAO();
    private static let realm = try! Realm();
    
    override private init() {
        let folderPath = UserDAO.realm.configuration.fileURL!.deletingLastPathComponent().path;
        try! FileManager.default.setAttributes([FileAttributeKey(rawValue: "NSFileProtectionKey"): FileProtectionType.none],ofItemAtPath: folderPath);
    }
    
    class func getInstance() -> UserDAO {
        return UserDAO.userInstance;
    }
    
    func insertUser(userObj: User) {
        try! UserDAO.realm.write {
            UserDAO.realm.add(userObj);
        }
        print("User has been inserted into DB");
    }
    
    func isUser(email : String , password : String)-> String?{
        let user = UserDAO.realm.objects(User.self).filter("email=%@ AND password=%@", email , password)
        if user.count==0 {
            print("is empty")
            return nil
        }
        return user[0].id
    }
    
    func getUserByID(userId : String) -> User?{
        let user = UserDAO.realm.object(ofType: User.self, forPrimaryKey: userId)
        return user
    }
    
    func updateUserData(newUserData : User){
        print("in user update method")
        try! UserDAO.realm.write {
            UserDAO.realm.add(newUserData, update: true)
        }
        print("update user values")
        print("===> \(String(describing: UserDAO.realm.object(ofType: User.self, forPrimaryKey: newUserData.id)))")
    }
    
    func saveProfilePic(imgData: Data, userId: String) {
        print("in profile picture update method");
        let user = UserDAO.realm.object(ofType: User.self, forPrimaryKey: userId);
        try! UserDAO.realm.write {
            user?.profilePic = imgData;
            UserDAO.realm.add(user!, update: true);
        }
        print("image data: \(String(describing: user?.profilePic))");
    }
    
    func addCarForUser(newCar: Car, userObj: User) {
        try! UserDAO.realm.write {
            userObj.cars.append(newCar)
            UserDAO.realm.add(userObj, update: true);
        }
    }
    
}
