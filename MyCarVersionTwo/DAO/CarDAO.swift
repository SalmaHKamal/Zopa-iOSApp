//
//  CarDAO.swift
//  MyCarVersionTwo
//
//  Created by Yasmin Ahmed on 5/31/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import RealmSwift

class CarDAO: NSObject {

    private static let carInstance = CarDAO();
    private static let realm = try! Realm();
    
    override private init() {
        let folderPath = CarDAO.realm.configuration.fileURL!.deletingLastPathComponent().path;
        try! FileManager.default.setAttributes([FileAttributeKey(rawValue: "NSFileProtectionKey"): FileProtectionType.none],ofItemAtPath: folderPath);
    }
    
    class func getInstance() -> CarDAO {
        return CarDAO.carInstance;
    }
    
    func insertCar(carObj: Car) {
        try! CarDAO.realm.write {
            CarDAO.realm.add(carObj);
        }
        print("Car has been inserted into DB");
    }
    
    /*
    func getAllCars(userID : String) -> [Car]{
        let results : Results<Car> = CarDAO.realm.objects(Car.self).filter("owner = %@ " , userID)
        let resArray : [Car] = Array(results)
        
        return resArray
    }*/
    
    //---------
    func getCarByID(carId : String , userId : String) -> Car {
        
        let car : Car = CarDAO.realm.object(ofType: Car.self, forPrimaryKey: carId)!
        return car
    }
    
    //--------
    func deleteCar(carId : String){
        
        if let car = CarDAO.realm.object(ofType: Car.self, forPrimaryKey: carId)
        {
            try! CarDAO.realm.write {
                CarDAO.realm.delete(car)
            }
            
            print(CarDAO.realm.objects(Car.self))
        }
    }
    
    //---------
    
    func deleteAllCars(){
        
        try! CarDAO.realm.write {
            CarDAO.realm.deleteAll()
            print("All Cars deleted")
            print("==> \(CarDAO.realm.objects(Car.self))")
        }
        
    }
    
    //---------
    func updateCar(newCarData : Car){
        print("in update method")
       
        try! CarDAO.realm.write {
            CarDAO.realm.add(newCarData, update: true)
        }
        
        print("update car values")
        print("===> \(String(describing: CarDAO.realm.object(ofType: Car.self, forPrimaryKey: newCarData.id)))")
    }
    
    func updateCarOilsList(carObj : Car, oilObj : Oil){
        print("in oil obj update method")
        
        try! CarDAO.realm.write {
            carObj.prevOils.append(oilObj);
            CarDAO.realm.add(carObj, update: true)
        }
        
        print("update car values")
        print("===> \(String(describing: CarDAO.realm.object(ofType: Car.self, forPrimaryKey: carObj.id)))")
    }
    
    func updateCarWashsList(carObj : Car, carWashObj : CarWash){
        print("in carWash obj update method")
        
        try! CarDAO.realm.write {
            carObj.prevCarWashings.append(carWashObj);
            CarDAO.realm.add(carObj, update: true)
        }
        
        print("update car values")
        print("===> \(String(describing: CarDAO.realm.object(ofType: Car.self, forPrimaryKey: carObj.id)))")
    }
    
    func updateCarRefuelsList(carObj : Car, carRefuelObj : Refuel){
        print("in refuel obj update method")
        
        try! CarDAO.realm.write {
            carObj.prevRefuels.append(carRefuelObj);
            CarDAO.realm.add(carObj, update: true)
        }
        
        print("update car values")
        print("===> \(String(describing: CarDAO.realm.object(ofType: Car.self, forPrimaryKey: carObj.id)))")
    }
    
    func test(){
        print("test function")
    }
    
    func saveCarPic(imgData: Data, carId: String) {
        print("in car picture update method");
        let car = CarDAO.realm.object(ofType: Car.self, forPrimaryKey: carId);
        try! CarDAO.realm.write {
            car?.image = imgData;
            CarDAO.realm.add(car!, update: true);
        }
        print("car image data: \(String(describing: car?.image))");
    }
    

}
