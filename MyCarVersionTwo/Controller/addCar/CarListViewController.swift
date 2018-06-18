//
//  CarListViewController.swift
//  MyCarVersionTwo
//
//  Created by Sayed Abdo on 5/20/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
//import Floaty
import Realm
import DTZFloatingActionButton

class CarListViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , updateCarListTableProtocol{

    //outlets
    @IBOutlet weak var carListTable: UITableView!
    
    //variables
    var listOfCars : [Car]?
    
    lazy var floatingButton = DTZFloatingActionButton(frame:CGRect(x: view.frame.size.width - 40 - 20,y: view.frame.size.height - 40 - 60,width: 40,height: 40));
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carListTable.delegate = self
        carListTable.dataSource = self
        
        //navigation title
        self.navigationItem.title = "Car List"
        
        //floating button
        addFloatingBtn()
    }
 
    override func viewWillAppear(_ animated: Bool) {
        
        listOfCars = Array<Car>()
        
        let userDef = UserDefaults.standard;
        let userId: String = userDef.value(forKey: "userId") as! String;
        //let results : [Car] = CarDAO.getInstance().getAllCars(userID: userId as! String);
        var userObj: User = UserDAO.getInstance().getUserByID(userId: userId)!
        print("user name: \(userObj.cars.count)")
        var results = Array<Car>()
        results.append(contentsOf: userObj.cars)
        listOfCars?.append(contentsOf: results)
        print("results count: \(results.count)")
        self.carListTable.reloadData()
    }
    
    func addFloatingBtn(){
        
        floatingButton.handler = { _ in
            self.openSingleCarCtrl()
        }
        floatingButton.isScrollView = true;
        floatingButton.buttonColor = UIColor.white;
        floatingButton.plusColor = UIColor.gray
        self.view.addSubview(floatingButton);
    }
    
    func openSingleCarCtrl(){
        
        let detailsVc : SingleCarDataVC = storyboard?.instantiateViewController(withIdentifier:"SingleCarData") as! SingleCarDataVC
        
        detailsVc.singleCar?.image = UIImagePNGRepresentation(UIImage(named : "car_image.jpg")!)!
        detailsVc.singleCar?.name = ""
        detailsVc.singleCar?.model = ""
        detailsVc.singleCar?.year = ""
        detailsVc.singleCar?.desc = ""
        detailsVc.delegate = self
        
        self.navigationController?.pushViewController(detailsVc, animated: true)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("listOfCars count: \(listOfCars!.count)")
        return listOfCars!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Cell = carListTable.dequeueReusableCell(withIdentifier: "singleCarCell", for: indexPath)

//        // get subView and add it on a cell
//        let subView = CardViewController.init(frame: CGRect(x:0 , y:0 , width: Cell.bounds.width , height : Cell.bounds.height))
//        subView.carNameLabel.text = listOfCars![indexPath.row].name
//        let img = UIImage(data : (listOfCars![indexPath.row].image))
//        subView.carImageView.image = img
//        subView.closeBtn.addTarget(self, action: #selector(deleteCar(_ :)), for: .touchUpInside)
//        Cell.contentView.addSubview(subView)
        let carName = Cell.viewWithTag(2) as! UILabel
        carName.text = listOfCars![indexPath.row].name
        let carImg = Cell.viewWithTag(1) as! UIImageView
        let img = UIImage(data : (listOfCars![indexPath.row].image))
        carImg.image = img
        let carDeleteButton = Cell.viewWithTag(3) as! UIButton
        carDeleteButton.addTarget(self, action: #selector(deleteCar(_ :)), for: .touchUpInside)
        return Cell
    }
    
    @objc func deleteCar(_ sender: Any){
        
        print("delete btn clicked")
        let buttonPosition : CGPoint = (sender as AnyObject).convert((sender as AnyObject).bounds.origin, to: carListTable)
        let indexPath = carListTable.indexPathForRow(at: buttonPosition)
        
        let seletedCar = listOfCars![(indexPath?.row)!]
        //remove from database
        CarDAO.getInstance().deleteCar(carId: seletedCar.id)
        
        listOfCars?.remove(at: (indexPath?.row)!)
        
        carListTable.deleteRows(at: [indexPath!], with: .left)
        
        for i in listOfCars! {
            print("name of car is \(i.name)")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsVc : SingleCarDataVC = storyboard?.instantiateViewController(withIdentifier:"SingleCarData") as! SingleCarDataVC
        detailsVc.delegate = self
        detailsVc.singleCar = listOfCars?[indexPath.row]
      
        self.navigationController?.pushViewController(detailsVc, animated: true)
    }

    func updateTableValues(newCar: Car) {
        
        listOfCars?.append(newCar)
        
        /*for i in listOfCars! {
            print(i.owner)
        }*/
        
        self.carListTable.reloadData()
    }
    

}
