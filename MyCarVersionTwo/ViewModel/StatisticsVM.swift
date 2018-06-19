//
//  StatisticsVM.swift
//  MyCarVersionTwo
//
//  Created by Sayed Abdo on 6/17/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit

class StatisticsVM: NSObject {

    public static let shared = StatisticsVM()
    
    let formatter = DateFormatter()
    
    var userCars = [Car]()
    
    private var carOilDates : [String] = [String]()
    private var carOilPrices : [Double] = [Double]()
    
    private var carRefuelDates : [String] = [String]()
    private var carRefPrices : [Double] = [Double]()
    private var carRefAmount : [Double] = [Double]()
    
    private var carWashDates : [String] = [String]()
    private var carWashPrices : [Double] = [Double]()
    var logedUser : User?
    var selectedCar : Car?
    var selectCarFlag = false
    
     func setSelectedCar(selectedCarIndex : Int) {
        logedUser = UserDAO.getInstance().getUserByID(userId: CommonMethods.getloggedInUserId())
        userCars = Array((logedUser?.cars)!)
        selectedCar = userCars[selectedCarIndex]
    }
    
    func getOilDatesAndPrice()->([String],[Double]){
        formatter.dateFormat = "EEE, dd MMM yyyy hh:mm:ss +zzzz"
        formatter.locale = Locale.init(identifier: "en_GB")
        formatter.dateFormat = "MM-dd-yyyy"
        carOilDates.removeAll()
        carOilPrices.removeAll()
        if let prevOils = selectedCar?.prevOils {
            for o in prevOils{
                carOilDates.append(formatter.string(from: o.date))
                carOilPrices.append(o.price)
            }
        }
        return (carOilDates, carOilPrices)
    }
    func getRefeulDatesAndPrice()->([String],[Double],[Double]){
        formatter.dateFormat = "EEE, dd MMM yyyy hh:mm:ss +zzzz"
        formatter.locale = Locale.init(identifier: "en_GB")
        formatter.dateFormat = "MM-dd-yyyy"
        carRefuelDates.removeAll()
        carRefPrices.removeAll()
        carRefAmount.removeAll()
        if let prevFuels = selectedCar?.prevRefuels {
            for ref in prevFuels{
                carRefuelDates.append(formatter.string(from: ref.date))
                print("Dateobj: \(formatter.string(from: ref.date))")
                carRefPrices.append(ref.price)
                carRefAmount.append(ref.amount)
            }
        }
        return (carRefuelDates , carRefPrices , carRefAmount )
    }
    
    func getWashDatesAndPrice()->([String],[Double]){
        formatter.dateFormat = "EEE, dd MMM yyyy hh:mm:ss +zzzz"
        formatter.locale = Locale.init(identifier: "en_GB")
        formatter.dateFormat = "MM-dd-yyyy"
        carWashDates.removeAll()
        carWashPrices.removeAll()
        if let prevWashs = selectedCar?.prevCarWashings {
            for w in prevWashs{
                carWashDates.append(formatter.string(from: w.washingDate))
                carWashPrices.append(w.washingPrice)
            }
        }
        return (carWashDates , carWashPrices)
    }
    
}
