//
//  RefuelViewController.swift
//  MyCarVersionTwo
//
//  Created by Yasmin Ahmed on 6/12/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import DTZFloatingActionButton

class RefuelViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    @IBOutlet weak var refuelsTableView: UITableView!
    
    lazy var floatingButton = DTZFloatingActionButton(frame:CGRect(x: view.frame.size.width - 40 - 20,y: view.frame.size.height - 40 - 60,width: 40,height: 40));
    
    override func viewDidLoad() {
        super.viewDidLoad();
        addFloatingBtn();
        refuelsTableView.separatorStyle = UITableViewCellSeparatorStyle.none;
    }
    
    func addFloatingBtn(){
        floatingButton.handler = {
            button in
            print("add new refuel btn clicked");
            let refuelDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "refuelDetailsId") as! RefuelDetailsViewController;
            self.navigationController?.pushViewController(refuelDetailsVC, animated: true);
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
        return 4;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = refuelsTableView.dequeueReusableCell(withIdentifier: "refuelCell", for: indexPath);
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let refuelDetailsVC = storyboard?.instantiateViewController(withIdentifier: "refuelDetailsId") as! RefuelDetailsViewController;
        self.navigationController?.pushViewController(refuelDetailsVC, animated: true);
    }
}

