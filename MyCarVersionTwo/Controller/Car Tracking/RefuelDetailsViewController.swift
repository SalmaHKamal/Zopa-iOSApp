//
//  RefuelDetailsViewController.swift
//  MyCarVersionTwo
//
//  Created by Yasmin Ahmed on 6/12/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit

class RefuelDetailsViewController: UIViewController {

    @IBOutlet weak var refuelType: UITextField!
    @IBOutlet weak var refuelPrice: UITextField!
    @IBOutlet weak var refuelPlcae: UITextField!
    @IBOutlet weak var refuelExtraNotes: UITextView!
    @IBOutlet weak var refuelDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setRightBarButton(UIBarButtonItem(title: "save", style: UIBarButtonItemStyle.done, target: self, action: #selector(save)), animated: true)
    }

    @objc func save(){
        print("save")
    }
}
