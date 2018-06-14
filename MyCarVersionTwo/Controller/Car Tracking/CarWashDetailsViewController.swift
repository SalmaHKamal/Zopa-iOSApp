//
//  CarWashDetailsViewController.swift
//  MyCarVersionTwo
//
//  Created by Yasmin Ahmed on 6/12/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit

class CarWashDetailsViewController: UIViewController {

    @IBOutlet weak var carWashPlace: UITextField!
    @IBOutlet weak var carWashPrice: UITextField!
    @IBOutlet weak var carWashDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setRightBarButton(UIBarButtonItem(title: "save", style: UIBarButtonItemStyle.done, target: self, action: #selector(save)), animated: true)

    }
    
    @objc func save(){
        print("save")
    }

}
