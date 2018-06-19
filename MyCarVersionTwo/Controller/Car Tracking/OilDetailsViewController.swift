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
    var oil : Oil?
    var selectedOilDate : Date = Date()
    var dateFlag = false
    let loggedUserId = CommonMethods.getloggedInUserId()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setRightBarButton(UIBarButtonItem(title: "save", style: UIBarButtonItemStyle.done, target: self, action: #selector(save)), animated: true)
        oilDate.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
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
       
        if dateFlag {
            oil = Oil(oilTypeVal: oilType.text!, numOfKmVal: NSString(string: distance.text!).doubleValue, oilPriceVal: NSString(string: oilPrice.text!).doubleValue, dateVal: selectedOilDate)
            myOilProtocol?.addOilToCart(oilObj: oil!)
        } else {
            self.view.makeToast("must choose a date", duration: 3.0, position: .bottom)
            return
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        dateFlag = true
        selectedOilDate = sender.date
        let components 
            = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year {
            print("oil date: \(day) \(month) \(year)")
            selectedDateVal.text = "\(day) / \(month) / \(year)"
        }
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
