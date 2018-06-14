//
//  WashViewController.swift
//  MyCarVersionTwo
//
//  Created by Yasmin Ahmed on 6/12/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import DTZFloatingActionButton

class WashViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , CarWashProtocol {
    
    @IBOutlet weak var washingsTableView: UITableView!
    
    lazy var floatingButton = DTZFloatingActionButton(frame:CGRect(x: view.frame.size.width - 40 - 20,y: view.frame.size.height - 40 - 60,width: 40,height: 40));
    var carWashArr = Array<CarWash>();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        addFloatingBtn();
        washingsTableView.separatorStyle = UITableViewCellSeparatorStyle.none;
        
        self.title = "Car Wash"
        let backImg = UIImage(named: "back");
        self.navigationItem.setLeftBarButton(UIBarButtonItem(image: backImg, style: UIBarButtonItemStyle.done, target: self, action: #selector(backHome)), animated: true)
    }
    
    func addCarWashToCart(carWashObj: CarWash) {
        carWashArr.append(carWashObj);
    }
    
    @objc func backHome(){
        print("test")
        //let homeVc = storyboard?.instantiateViewController(withIdentifier: "homeVC") as! HomeViewController
        dismiss(animated: true, completion: nil)
    }
    
    func addFloatingBtn(){
        floatingButton.handler = {
            button in
            print("add new car wash btn clicked");
            let carWashDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "carWashDetailsId") as! CarWashDetailsViewController;
            carWashDetailsVC.myCarWashProtocol = self;
            self.navigationController?.pushViewController(carWashDetailsVC, animated: true);
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
        return 4;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = washingsTableView.dequeueReusableCell(withIdentifier: "carWashCell", for: indexPath);
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let carWashDetailsVC = storyboard?.instantiateViewController(withIdentifier: "carWashDetailsId") as! CarWashDetailsViewController;
        self.navigationController?.pushViewController(carWashDetailsVC, animated: true);
    }
}
