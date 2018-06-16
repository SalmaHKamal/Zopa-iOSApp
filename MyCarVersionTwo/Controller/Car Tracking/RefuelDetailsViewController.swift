//
//  RefuelDetailsViewController.swift
//  MyCarVersionTwo
//
//  Created by Yasmin Ahmed on 6/12/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit

class RefuelDetailsViewController: UIViewController {

    @IBOutlet weak var refuelType: UITextField!
    @IBOutlet weak var refuelPrice: UITextField!
    @IBOutlet weak var refuelPlace: UITextField!
    @IBOutlet weak var refuelAmount: UITextField!
    @IBOutlet weak var refuelExtraNotes: UITextView!
    @IBOutlet weak var refuelDate: UIDatePicker!
    @IBOutlet weak var selectedDateVal: UILabel!
    
    let refuelInstance = RefuelDAO.getInstance();
    var myRefuelProtocol: RefuelProtocol?
    let refuel = Refuel()
    let loggedUserId = CommonMethods.getloggedInUserId()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setRightBarButton(UIBarButtonItem(title: "save", style: UIBarButtonItemStyle.done, target: self, action: #selector(save)), animated: true)
    }

    @objc func save(){
        print("save refuel data")
        
        guard let refuel_type = refuelType.text , !refuel_type.isEmpty else{
            self.view.makeToast("enter refuel type", duration: 3.0, position: .bottom)
            return
        }
        guard let refuel_price = refuelPrice.text , !refuel_price.isEmpty else{
            self.view.makeToast("enter refuel price", duration: 3.0, position: .bottom)
            return
        }
        guard let refuel_amount = refuelAmount.text , !refuel_amount.isEmpty else{
            self.view.makeToast("enter refuel amount", duration: 3.0, position: .bottom)
            return
        }
        guard let refuel_place = refuelPlace.text , !refuel_place.isEmpty else{
            self.view.makeToast("enter refuel place", duration: 3.0, position: .bottom)
            return
        }
        
        refuel.type = refuel_type
        refuel.price = NSString(string: refuel_price).doubleValue
        refuel.amount = NSString(string: refuel_amount).doubleValue
        refuel.place = refuel_place
        refuelDate.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        
        refuelInstance.insertRefuelData(refuelObj: refuel)
        myRefuelProtocol?.addRefuelToCart(refuelObj: refuel)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        print("ggggggggggggg")
        refuel.date = sender.date
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year {
            print("refuel date: \(day) \(month) \(year)")
            selectedDateVal.text = "\(day) / \(month) / \(year)"
        }
    }
}
