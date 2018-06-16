//
//  TestDropDownViewController.swift
//  MyCarVersionTwo
//
//  Created by Yasmin Ahmed on 6/14/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import SwiftyPickerPopover

class TestDropDownViewController: UIViewController {

    
    @IBAction func showDropDown(_ sender: UIButton) {
        
        let p = StringPickerPopover(title: "StringPicker", choices: ["value 1","value 2","value 3"])
            //.setDisplayStringFor(displayStringFor)
            .setFont(UIFont.boldSystemFont(ofSize: 14))
            .setFontColor(.blue)
            .setDoneButton(action: { popover, selectedRow, selectedString in
                print("done row \(selectedRow) \(selectedString)")
                popover.disappear()
            })
            .setCancelButton(action: {_, _, _ in
                print("cancel") })
        
        p.appear(originView: sender, baseViewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
