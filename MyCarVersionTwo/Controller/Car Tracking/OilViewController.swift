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
        drawCarDropDownList()
    }
    
    func addOilToCart(oilObj: Oil) {
        oilArr.append(oilObj);
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

    func displayCarMenu(){
        let items = ["World", "Sports", "Culture", "Business", "Travel"]// car from daos
        let titleView = TitleView(navigationController: navigationController!, title: "Car", items: items)
        titleView?.action = { [weak self] index in
            print("select \(index)")
        }
        
        navigationItem.titleView = titleView
    }
    
    func addFloatingBtn(){
        floatingButton.handler = {
            button in
            print("add new oil btn clicked");
            let oilDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "oilDetailsId") as! OilDetailsViewController;
            oilDetailsVC.myOilProtocol = self;
            self.navigationController?.pushViewController(oilDetailsVC, animated: true);
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
            self?.selectedCar = (self?.cars[index])!
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
