//
//  ViewController.swift
//  MyCarVersionTwo
//
//  Created by mac on 6/11/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDataSource , UITableViewDelegate{
    
    @IBOutlet weak var SiteTable: UITableView!
    let sites = ["Asfaalt","CarParts","jumia"]
    override func viewDidLoad() {
        super.viewDidLoad()
        SiteTable.dataSource=self
        SiteTable.delegate=self
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SiteTable.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = sites[indexPath.row]
        cell?.textLabel?.textColor = UIColor.white
        
        return cell!
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="siteName"{
            var selectedRow=self.SiteTable.indexPathForSelectedRow
            let webVC:WebViewController=segue.destination as! WebViewController
            webVC.siteID=selectedRow!.row
        }
    }
    
}

