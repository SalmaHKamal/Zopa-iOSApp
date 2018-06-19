//
//  RefuelViewController.swift
//  MyCarVersionTwo
//
//  Created by Yasmin Ahmed on 6/12/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import DTZFloatingActionButton
import Dropdowns

class RefuelViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , RefuelProtocol{
    
    @IBOutlet weak var refuelsTableView: UITableView!
    
    lazy var floatingButton = DTZFloatingActionButton(frame:CGRect(x: view.frame.size.width - 40 - 20,y: view.frame.size.height - 40 - 60,width: 40,height: 40));
    var refuelArr = Array<Refuel>();
    var selectedCar: Car?
    var cars : [Car] = [Car]()
    let userInstance = UserDAO.getInstance()
    let carInstance = CarDAO.getInstance()
    let refuelInstance = RefuelDAO.getInstance()
    var carChosenFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad();
        addFloatingBtn();
        refuelsTableView.separatorStyle = UITableViewCellSeparatorStyle.none;
        
        self.title = "Refuel"
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
    
    func addRefuelToCart(refuelObj: Refuel) {
        refuelInstance.insertRefuelData(refuelObj: refuelObj)
        carInstance.updateCarRefuelsList(carObj: selectedCar!, carRefuelObj: refuelObj)
        refuelArr.append(refuelObj)
        self.refuelsTableView.reloadData();
    }
    
    @objc func backHome(){
        dismiss(animated: true, completion: nil)
    }
    
    func addFloatingBtn(){
        floatingButton.handler = {
            button in
            print("add new refuel btn clicked");
            if self.carChosenFlag == false {
                if self.carChosenFlag == false {
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil);
                    let alertActions = [okAction];
                    CommonMethods.showAlert(base: self, actions: alertActions, alertTitle: "Not Allowed", alertMsg: "You must choose a car first")
                }
            }
            else {
                let refuelDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "refuelDetailsId") as! RefuelDetailsViewController;
                refuelDetailsVC.myRefuelProtocol = self;
                self.navigationController?.pushViewController(refuelDetailsVC, animated: true);
            }
        }
        floatingButton.isScrollView = true;
        floatingButton.buttonColor = UIColor.purple;
        self.view.addSubview(floatingButton);
    }

}

// Mark: - tableview methods
extension RefuelViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refuelArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = refuelsTableView.dequeueReusableCell(withIdentifier: "refuelCell", for: indexPath);
        let refuelDateLbl = cell.viewWithTag(1) as! UILabel
        let components = Calendar.current.dateComponents([.year, .month, .day], from: refuelArr[indexPath.row].date)
        if let day = components.day, let month = components.month, let year = components.year {
            refuelDateLbl.text = "\(day) / \(month) / \(year)"
        }
        let refuelPrice = cell.viewWithTag(2) as! UILabel
        refuelPrice.text = String(refuelArr[indexPath.row].price)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let refuelDetailsVC = storyboard?.instantiateViewController(withIdentifier: "refuelDetailsId") as! RefuelDetailsViewController;
        self.navigationController?.pushViewController(refuelDetailsVC, animated: true);
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
            self?.refuelArr = Array((self?.selectedCar!.prevRefuels)!)
            print("refuels count\(Array((self?.selectedCar!.prevRefuels)!).count)")
            self?.refuelsTableView.reloadData()
        }
        navigationItem.titleView = titleView
    }
}

