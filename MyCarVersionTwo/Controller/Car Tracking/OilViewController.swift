//
//  OilViewController.swift
//  MyCarVersionTwo
//
//  Created by mac on 6/10/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Dropdowns
import Floaty

class OilViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    //outlets
    @IBOutlet weak var myTableView: UITableView!
    

    //var
    //var listOfOilData = [Oil]?

    override func viewDidLoad() {
        super.viewDidLoad()

        displayCarMenu()
        addFloatingBtn()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(title: "save", style: UIBarButtonItemStyle.done, target: self, action: #selector(save)), animated: true)
        
    }
    
    @objc func save(){
        print("test")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setTableBgImage()
        
        //listOfOilData = [Oil]()
        
        
//        let results : [Oil] = OilDAO.getInstance()
//        listOfOilData = results
//        self.myTableView.reloadData()

    }
    
    func getloggedInUserId() -> String {
        let userDef = UserDefaults.standard;
        return userDef.value(forKey: "userId") as! String;
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
        
        let floaty = Floaty()
        floaty.buttonColor = UIColor.brown
        floaty.addItem(title: "new Car", handler: {item in
            
            //openOilDetailsVC()
        })
        
        self.view.addSubview(floaty)
    }
    
    func openOilDetailsVC(){
        
//        let oilDetailsVc = storyboard?.instantiateViewController(withIdentifier:"oilDetails") as! OilDetailsViewController
//
//        oilDetailsVc.singleCar?.image = UIImagePNGRepresentation(UIImage(named : "car_image.jpg")!)!
//        oilDetailsVc.singleCar?.name = ""
//        oilDetailsVc.singleCar?.model = ""
//        oilDetailsVc.singleCar?.year = ""
//        oilDetailsVc.singleCar?.desc = ""
//
//        oilDetailsVc.delegate = self
//
//        self.navigationController?.pushViewController(detailsVc, animated: true)
//
    }
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "singleOilCell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let oilDetailsVC = storyboard?.instantiateViewController(withIdentifier: "oilDetails") as! OilDetailsViewController
        
        self.navigationController?.pushViewController(oilDetailsVC, animated: true)
    }
    
}

extension OilViewController : updateCarListTableProtocol{
    
    func updateTableValues(newCar: Car) {
        
    }
    
    
}