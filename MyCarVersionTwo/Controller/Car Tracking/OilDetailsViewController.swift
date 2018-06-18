//
//  OilDetailsViewController.swift
//  MyCarVersionTwo
//
//  Created by Sayed Abdo on 6/11/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import UIDropDown
import Dropdowns

class OilDetailsViewController: UIViewController {

    @IBOutlet weak var oilType: UITextField!
    @IBOutlet weak var distance: UITextField!
    @IBOutlet weak var oilPrice: UITextField!
    @IBOutlet weak var oilDate: UIDatePicker!
    @IBOutlet weak var selectedDateVal: UILabel!
    
    var selectedCar = Car()
    var cars : [Car] = [Car]()
    let oilInstance = OilDAO.getInstance();
    var myOilProtocol: OilProtocol?
    let oil = Oil()
    let loggedUserId = CommonMethods.getloggedInUserId()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setRightBarButton(UIBarButtonItem(title: "save", style: UIBarButtonItemStyle.done, target: self, action: #selector(save)), animated: true)
//        displayCarMenu()
        getAllCarsForMenu()
//        displayAllCarsMenu()
//        drawDropDownList()
    }
    func getAllCarsForMenu(){
//        let userId = getLoggedInUserId()
        cars = CommonMethods.getAllCarsForUser()
        print("cars count: \(cars.count)")
        //displayAllCarsMenu()
//        displayCarMenu()
    }
    
    @objc func save(){
        print("save oil date")
      
        guard let oil_type = oilType.text , !oil_type.isEmpty else{
            self.view.makeToast("enter oil type", duration: 3.0, position: .bottom)
            return
        }
        guard let oil_price = oilPrice.text , !oil_price.isEmpty else{
            self.view.makeToast("enter oil price", duration: 3.0, position: .bottom)
            return
        }
        guard let oil_distance = distance.text , !oil_distance.isEmpty else{
            self.view.makeToast("enter oil distance", duration: 3.0, position: .bottom)
            return
        }
        
        oil.type = oil_type
        oil.price = NSString(string: oil_price).doubleValue
        oil.numOfKm = NSString(string: oil_distance).doubleValue
        oilDate.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        
        oilInstance.insertNewOil(oilObj: oil)
        myOilProtocol?.addOilToCart(oilObj: oil)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        oil.date = sender.date
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year {
            print("oil date: \(day) \(month) \(year)")
            selectedDateVal.text = "\(day) / \(month) / \(year)"
        }
    }
    
    func displayAllCarsMenu(){

        let drop = UIDropDown(frame: CGRect(x: 0, y: 0, width: 200, height: 40))

        drop.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY)
        drop.placeholder = "Select your car..."

        for i in cars{
            print(i.name)
            drop.options.append(i.name)
        }

        drop.didSelect { (option, index) in
            print("You just select: \(option) at index: \(index)")
        }

        drop.textColor = UIColor.white
        self.view.addSubview(drop)
    }

    func displayCarMenu(){
        var items = Array<String>()
        for car in cars {
            items.append(car.name)
        }
        let titleView = TitleView(navigationController: navigationController!, title: "Car", items: items)
        titleView?.action = { [weak self] index in
            print("select \(index)")
        }

        navigationItem.titleView = titleView
    }

    func drawDropDownList(){
        var items : [String] = [String]()
        for i in cars {
            items.append(i.name)
        }
        let titleView = TitleView(navigationController: navigationController!, title: "choose car", items: items)
        titleView?.action = { [weak self] index in
            print("select \(index)")
            self?.selectedCar = (self?.cars[index])!
        }
        navigationItem.titleView = titleView
    }

}
