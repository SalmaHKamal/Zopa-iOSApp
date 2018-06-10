//
//  MaintViewController.swift
//  MyCarVersionTwo
//
//  Created by mac on 6/10/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
 import Dropdowns
class MaintViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
     @IBOutlet weak var myTable: UITableView!
       let num = ["1", "2", "3", "4", "5"]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return num.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = myTable.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text=num[indexPath.row]
        cell?.detailTextLabel?.text=num[indexPath.row]
        
        return cell!
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTable.delegate=self
        myTable.dataSource=self
        
        let items = ["World", "Sports", "Culture", "Business", "Travel"]// car from daos
        let titleView = TitleView(navigationController: navigationController!, title: "Car", items: items)
        titleView?.action = { [weak self] index in
            print("select \(index)")
        }
        
        navigationItem.titleView = titleView
    }

   

}
