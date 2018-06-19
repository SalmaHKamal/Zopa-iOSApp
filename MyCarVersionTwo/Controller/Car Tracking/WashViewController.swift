//
//  WashViewController.swift
//  MyCarVersionTwo
//
//  Created by Yasmin Ahmed on 6/12/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import DTZFloatingActionButton
import Dropdowns

class WashViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , CarWashProtocol {
    
    @IBOutlet weak var washingsTableView: UITableView!
    
    lazy var floatingButton = DTZFloatingActionButton(frame:CGRect(x: view.frame.size.width - 40 - 20,y: view.frame.size.height - 40 - 60,width: 40,height: 40));
    var carWashArr = Array<CarWash>();
    var selectedCar: Car?
    var cars : [Car] = [Car]()
    let userInstance = UserDAO.getInstance()
    let carInstance = CarDAO.getInstance()
    let carWashInstance = CarWashDAO.getInstance()
    var carChosenFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad();
        addFloatingBtn();
        washingsTableView.separatorStyle = UITableViewCellSeparatorStyle.none;
        
        self.title = "Car Wash"
        let backImg = UIImage(named: "back");
        self.navigationItem.setLeftBarButton(UIBarButtonItem(image: backImg, style: UIBarButtonItemStyle.done, target: self, action: #selector(backHome)), animated: true)
        
        let userObj: User = userInstance.getUserByID(userId: CommonMethods.getloggedInUserId())!
        cars.append(contentsOf: userObj.cars)
        print("cars count in oilView: \(cars.count)")
        if cars.count == 0 {
            self.title = "Sorry, You Should Add Car First!"
        } else {
            drawCarDropDownList()
        }
    }
    
    func addCarWashToCart(carWashObj: CarWash) {
        carWashInstance.insertCarWashData(carWashObj: carWashObj)
        carInstance.updateCarWashsList(carObj: selectedCar!, carWashObj: carWashObj)
        carWashArr.append(carWashObj)
        self.washingsTableView.reloadData();
    }
    
    @objc func backHome(){
        dismiss(animated: true, completion: nil)
    }
    
    func addFloatingBtn(){
        floatingButton.handler = {
            button in
            print("add new car wash btn clicked");
            if self.carChosenFlag == false {
                if self.carChosenFlag == false {
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil);
                    let alertActions = [okAction];
                    CommonMethods.showAlert(base: self, actions: alertActions, alertTitle: "Not Allowed", alertMsg: "You must choose a car first")
                }
            }
            else {
                let carWashDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "carWashDetailsId") as! CarWashDetailsViewController;
                carWashDetailsVC.myCarWashProtocol = self;
                self.navigationController?.pushViewController(carWashDetailsVC, animated: true);
            }
        }
        floatingButton.isScrollView = true;
        floatingButton.buttonColor = UIColor.purple;
        self.view.addSubview(floatingButton);
    }
}

// Mark: - tableview methods
extension WashViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carWashArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = washingsTableView.dequeueReusableCell(withIdentifier: "carWashCell", for: indexPath);
        let carWashDateLbl = cell.viewWithTag(1) as! UILabel
        let components = Calendar.current.dateComponents([.year, .month, .day], from: carWashArr[indexPath.row].washingDate)
        if let day = components.day, let month = components.month, let year = components.year {
            carWashDateLbl.text = "\(day) / \(month) / \(year)"
        }
        let carWashPlace = cell.viewWithTag(2) as! UILabel
        carWashPlace.text = String(carWashArr[indexPath.row].washingPlace)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let carWashDetailsVC = storyboard?.instantiateViewController(withIdentifier: "carWashDetailsId") as! CarWashDetailsViewController;
        self.navigationController?.pushViewController(carWashDetailsVC, animated: true);
    }
    
    func drawCarDropDownList(){
        var items : [String] = [String]()
        for car in cars {
            items.append(car.name)
        }
        let titleView = TitleView(navigationController: navigationController!, title: "choose car", items: items)
        titleView?.action = { [weak self] index in
            print("select \(index)")
            self?.carChosenFlag = true
            self?.selectedCar = (self?.cars[index])!
            self?.carWashArr = Array((self?.selectedCar!.prevCarWashings)!)
            print("washings count\(Array((self?.selectedCar!.prevCarWashings)!).count)")
            self?.washingsTableView.reloadData()
        }
        navigationItem.titleView = titleView
    }
}
