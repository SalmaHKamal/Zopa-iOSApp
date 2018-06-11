//
//  CarListViewController.swift
//  MyCarVersionTwo
//
//  Created by Sayed Abdo on 5/20/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Floaty
import Realm

class CarListViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , updateCarListTableProtocol{

    //outlets
    @IBOutlet weak var carListTable: UITableView!
    
    
    
    //variables
    var listOfCars : [Car]?
    
    
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
        listOfCars = [Car]()
        
        let userDef = UserDefaults.standard;
        let userId: String = userDef.value(forKey: "userId") as! String;
        let results : [Car] = CarDAO.getInstance().getAllCars(userID: userId as! String);
        listOfCars = results
        self.carListTable.reloadData()
    }
    
    func addFloatingBtn(){
        
        let floaty = Floaty()
        floaty.buttonColor = UIColor.brown
        floaty.addItem(title: "new Car", handler: {item in
            
            self.openSingleCarCtrl()
        })
        
        self.view.addSubview(floaty)
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
        return listOfCars!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Cell = carListTable.dequeueReusableCell(withIdentifier: "singleCarCell", for: indexPath)

        // get subView and add it on a cell
        let subView = CardViewController.init(frame: CGRect(x:0 , y:0 , width: 351 , height : 200))
        subView.carNameLabel.text = listOfCars![indexPath.row].name
        let img = UIImage(data : (listOfCars![indexPath.row].image))
        subView.carImageView.image = img
        subView.closeBtn.addTarget(self, action: #selector(deleteCar(_ :)), for: .touchUpInside)
        Cell.contentView.addSubview(subView)
        
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
        
        for i in listOfCars! {
            print(i.owner)
        }
        
        self.carListTable.reloadData()
    }
    

}
