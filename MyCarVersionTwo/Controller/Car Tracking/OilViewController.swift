//
//  OilViewController.swift
//  MyCarVersionTwo
//
//  Created by mac on 6/10/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Dropdowns
class OilViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let items = ["World", "Sports", "Culture", "Business", "Travel"]// car from daos
        let titleView = TitleView(navigationController: navigationController!, title: "Car", items: items)
        titleView?.action = { [weak self] index in
            print("select \(index)")
        }
        
        navigationItem.titleView = titleView
    }

  
}
