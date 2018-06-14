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
    
    var Cars : [Car] = [Car]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(title: "save", style: UIBarButtonItemStyle.done, target: self, action: #selector(save)), animated: true)

        //displayCarMenu()
        //getAllCarsForMenu()
        //displayAllCarsMenu()
    }
    
    @objc func save(){
        print("save oil date");
        let oil = Oil();
        oil.type = oilType.text!
      // oil.price = ((oilPrice.text!) as String).doubl
        //oil.numOfKm = distance.text!
        oil.date = oilDate.date
    }
    
    func getAllCarsForMenu(){
        
        let userId = getLoggedInUserId()
        Cars = CarDAO.getInstance().getAllCars(userID: userId)
        
    }
    
    func getLoggedInUserId() -> String {
        let userDef = UserDefaults.standard
        
        return userDef.value(forKey: "userId") as! String
    }
    
    func displayAllCarsMenu(){
        
        let drop = UIDropDown(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        
        drop.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY)
        drop.placeholder = "Select your car..."
       // drop.options = ["Mexico", "USA", "England", "France", "Germany", "Spain", "Italy", "Canada"]
        
        for i in Cars{

            print(i.name)
            drop.options.append(i.name)
        }
        
        drop.didSelect { (option, index) in
            //            self.label.text = "You just select \(option) at index: \(index)"
            print("You just select: \(option) at index: \(index)")
        }
        
        drop.textColor = UIColor.white
        self.view.addSubview(drop)
        
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        
        let oil : Oil = Oil()
        oil.date = sender.date
    }
    
    func displayCarMenu(){
        let items = ["World", "Sports", "Culture", "Business", "Travel"]// car from daos
        let titleView = TitleView(navigationController: navigationController!, title: "Car", items: items)
        titleView?.action = { [weak self] index in
            print("select \(index)")
        }
        
        navigationItem.titleView = titleView
        
    }
    


}
