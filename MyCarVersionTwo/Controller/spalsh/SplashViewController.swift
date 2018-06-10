//
//  SplashViewController.swift
//  MyCarVersionTwo
//
//  Created by mac on 6/7/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SplashViewController: UIViewController {

    @IBOutlet weak var indicatorView: NVActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicatorView.type = .ballSpinFadeLoader
        indicatorView.color = UIColor.white
        indicatorView.startAnimating()
        
        if checkUser() != nil && checkUser() ==  true {
            perform(#selector(showHome), with: nil, afterDelay: 5)
        }else{
            perform(#selector(showLogin), with: nil, afterDelay: 5)
        }
    }
    func checkUser() -> Bool?{
        let userDef = UserDefaults.standard
        let log = userDef.value(forKey: "isLoggedIn") as? Bool
        print(log ?? "")
        return log
    }
    
    @objc func showLogin(){
        performSegue(withIdentifier: "showLogin", sender: self)
    }
    @objc func showHome(){
        performSegue(withIdentifier: "showHome", sender: self)
    }


}
