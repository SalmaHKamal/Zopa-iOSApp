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

class OilViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    //outlets
    @IBOutlet weak var myTableView: UITableView!
    
    lazy var floatingButton = DTZFloatingActionButton(frame:CGRect(x: view.frame.size.width - 40 - 20,y: view.frame.size.height - 40 - 60,width: 40,height: 40));

    //var
    //var listOfOilData = [Oil]?

    override func viewDidLoad() {
        super.viewDidLoad()

        //displayCarMenu()
        addFloatingBtn();
        myTableView.separatorStyle = UITableViewCellSeparatorStyle.none;
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(title: "save", style: UIBarButtonItemStyle.done, target: self, action: #selector(save)), animated: true)
    }
    
    @objc func save(){
        print("test")
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        floatingButton.handler = {
            button in
            print("add new oil btn clicked");
            let oilDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "oilDetailsId") as! OilDetailsViewController;
            self.navigationController?.pushViewController(oilDetailsVC, animated: true);
        }
        floatingButton.isScrollView = true;
        floatingButton.buttonColor = UIColor.purple;
        self.view.addSubview(floatingButton);
    }
    
    func openOilDetailsVC(){
        
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "singleOilCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let oilDetailsVC = storyboard?.instantiateViewController(withIdentifier: "oilDetailsId") as! OilDetailsViewController
        self.navigationController?.pushViewController(oilDetailsVC, animated: true)
    }
}
