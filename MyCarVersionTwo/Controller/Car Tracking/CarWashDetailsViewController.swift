//
//  CarWashDetailsViewController.swift
//  MyCarVersionTwo
//
//  Created by Yasmin Ahmed on 6/12/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import UserNotifications

class CarWashDetailsViewController: UIViewController {

    @IBOutlet weak var carWashPlace: UITextField!
    @IBOutlet weak var carWashPrice: UITextField!
    @IBOutlet weak var carWashDate: UIDatePicker!
    @IBOutlet weak var selectedDateVal: UILabel!
    
    let carWashInstance = CarWashDAO.getInstance();
    var myCarWashProtocol: CarWashProtocol?
    var carWash : CarWash?
    let loggedUserId = CommonMethods.getloggedInUserId()
    var selectedOilDate : Date = Date()
    var dateFlag = false
    var dateComponent = DateComponents()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setRightBarButton(UIBarButtonItem(title: "save", style: UIBarButtonItemStyle.done, target: self, action: #selector(save)), animated: true)
        
        carWashDate.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    
    @objc func save(){
        print("save car wash data")
        
        guard let wash_place = carWashPlace.text , !wash_place.isEmpty else{
            self.view.makeToast("enter car wash place", duration: 3.0, position: .bottom)
            return
        }
        guard let wash_price = carWashPrice.text , !wash_price.isEmpty else{
            self.view.makeToast("enter car wash price", duration: 3.0, position: .bottom)
            return
        }
        
        if dateFlag {
            carWash = CarWash(washingPlaceVal: carWashPlace.text!, washingPriceVal: NSString(string: wash_price).doubleValue, washingDateVal: selectedOilDate)
            myCarWashProtocol?.addCarWashToCart(carWashObj: carWash!)
            
            //Notification
            showNotification()
        } else {
            print("in date test 1")
            self.view.makeToast("must choose a date", duration: 3.0, position: .center)
            return
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        print("in date test 2")
        dateFlag = true
        selectedOilDate = sender.date
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year {
            print("oil date: \(day) \(month) \(year)")
            
            dateComponent.day = day
            dateComponent.month = month
            dateComponent.year = year
            dateComponent.hour = 23
            dateComponent.minute = 0
            
            selectedDateVal.text = "\(day) / \(month) / \(year)"
        }
    }
    
    
    func showNotification(){
        
        print("notification called")
        let content = UNMutableNotificationContent()
        content.title = "notification"
        content.body = "This is a time to refuel"
        content.badge = 1
        content.sound = UNNotificationSound.default()
        
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        let request = UNNotificationRequest(identifier: "SalmaNotification", content: content, trigger: trigger)
        
        //actions defination
        //        let action1 = UNNotificationAction(identifier: "action1", title: "Action First", options: [.foreground])
        //        let action2 = UNNotificationAction(identifier: "action2", title: "Action Second", options: [.foreground])
        //
        //        let category = UNNotificationCategory(identifier: "actionCategory", actions: [action1,action2], intentIdentifiers: [], options: [])
        //
        //        UNUserNotificationCenter.current().setNotificationCategories([category])
        //
        UNUserNotificationCenter.current().add(request, withCompletionHandler:
            {(error) in
                
                if error != nil {
                    print(error?.localizedDescription)
                }
        }
        )
    }


}
