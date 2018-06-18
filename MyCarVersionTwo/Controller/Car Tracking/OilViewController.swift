////
//  OilViewController.swift
//  MyCarVersionTwo
//
//  Created by mac on 6/10/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Dropdowns
import DTZFloatingActionButton

class OilViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , OilProtocol {
    
    //outlets
    @IBOutlet weak var myTableView: UITableView!
    
    lazy var floatingButton = DTZFloatingActionButton(frame:CGRect(x: view.frame.size.width - 40 - 20,y: view.frame.size.height - 40 - 60,width: 40,height: 40));
    var oilArr = Array<Oil>();
    var selectedCar: Car?
    var cars : [Car] = [Car]()
    let userInstance = UserDAO.getInstance()
    let oilInstance = OilDAO.getInstance()
    let carInstance = CarDAO.getInstance()
    var carChosenFlag = false

    override func viewDidLoad() {
        super.viewDidLoad()

        addFloatingBtn();
        myTableView.separatorStyle = UITableViewCellSeparatorStyle.none;
        
        self.title = "Oil"
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
    
    func addOilToCart(oilObj: Oil) {
        oilInstance.insertNewOil(oilObj: oilObj)
        carInstance.updateCarOilsList(carObj: selectedCar!, oilObj: oilObj)
        oilArr.append(oilObj)
        self.myTableView.reloadData();
    }
    
    @objc func backHome(){
        dismiss(animated: true, completion: nil)
    }
    
    func setTableBgImage(){
        let backgroundImage = UIImage(named: "bg.jpg")
        let imageView = UIImageView(image: backgroundImage)
        self.myTableView.backgroundView = imageView
    }

    func addFloatingBtn(){
        floatingButton.handler = {
            button in
            print("add new oil btn clicked");
            print("carChosenFlag: \(self.carChosenFlag)")
            if self.carChosenFlag == false {
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil);
                let alertActions = [okAction];
                CommonMethods.showAlert(base: self, actions: alertActions, alertTitle: "Not Allowed", alertMsg: "You must choose a car first")
            }
            else {
                let oilDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "oilDetailsId") as! OilDetailsViewController;
                oilDetailsVC.myOilProtocol = self;
                self.navigationController?.pushViewController(oilDetailsVC, animated: true);
            }
        }
        floatingButton.isScrollView = true;
        floatingButton.buttonColor = UIColor.purple;
        self.view.addSubview(floatingButton);
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
            self?.oilArr = Array((self?.selectedCar!.prevOils)!)
            print("oils count\(Array((self?.selectedCar!.prevOils)!).count)")
            self?.myTableView.reloadData()
        }
        navigationItem.titleView = titleView
    }
}

extension OilViewController : updateCarListTableProtocol{
    func updateTableValues(newCar: Car) {
    }
}

// Mark: - tableview methods
extension OilViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return oilArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "singleOilCell", for: indexPath)
        let oilDateLbl = cell.viewWithTag(1) as! UILabel
        let components = Calendar.current.dateComponents([.year, .month, .day], from: oilArr[indexPath.row].date)
        if let day = components.day, let month = components.month, let year = components.year {
            oilDateLbl.text = "\(day) / \(month) / \(year)"
        }
        let oilPrice = cell.viewWithTag(2) as! UILabel
        oilPrice.text = String(oilArr[indexPath.row].price)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let oilDetailsVC = storyboard?.instantiateViewController(withIdentifier: "oilDetailsId") as! OilDetailsViewController
        self.navigationController?.pushViewController(oilDetailsVC, animated: true)
    }
}
