//
//  HomeViewController.swift
//  MyCarVersionTwo
//
//  Created by Yasmin Ahmed on 6/3/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var wholeView: UIView!
    @IBOutlet weak var sideMenuHolder: UIView!
    @IBOutlet weak var statisticsBtn: UIButton!
    @IBOutlet weak var vehiclesBtn: UIButton!
    @IBOutlet weak var historyBtn: UIButton!
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var aboutBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    
    var isSlideMenuHidden = true;
    var sideMenuButtons: Array<UIButton>?
    
    @IBAction func statisticsAction(_ sender: UIButton) {
    }
    
    @IBAction func vehiclesAction(_ sender: UIButton) {
    }
    
    @IBAction func historyAction(_ sender: UIButton) {
    }
    
    @IBAction func settingsAction(_ sender: UIButton) {
    }
    
    @IBAction func aboutAction(_ sender: UIButton) {
    }
    
    @IBAction func logoutAction(_ sender: UIButton) {
        print("in logout");
        let userDef = UserDefaults.standard;
        userDef.removeObject(forKey: "userId");
        let loginView = self.storyboard?.instantiateViewController(withIdentifier: "loginVC");
        self.present(loginView!, animated: true, completion: nil);
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuConstraint.constant = -177;
        sideMenuButtons = [statisticsBtn, vehiclesBtn, historyBtn, settingsBtn, aboutBtn, logoutBtn];
        
        let gesture = UITapGestureRecognizer(target: self, action: "wholeViewAction:");
        self.wholeView.addGestureRecognizer(gesture);
    }

    @objc func wholeViewAction(_ sender:UITapGestureRecognizer) {
        if (isSlideMenuHidden == false) {
            sideMenuConstraint.constant = -177;
            UIView.animate(withDuration: 0.3, animations:{
                self.view.layoutIfNeeded();
            });
            isSlideMenuHidden = true;
        }
    }
    
    @IBAction func showSideMenu(_ sender: UIButton) {
        if isSlideMenuHidden {
            sideMenuConstraint.constant = 0;
            for btn in sideMenuButtons! {
                btn.layer.shadowColor = UIColor.darkGray.cgColor;
                btn.layer.shadowOffset = CGSize(width: 2, height: 1);
                btn.layer.shadowRadius = 2;
                btn.layer.shadowOpacity = 1.0;
            }
            UIView.animate(withDuration: 0.3, animations:{
                self.view.layoutIfNeeded();
            });
        }
        else {
            sideMenuConstraint.constant = -177;
            UIView.animate(withDuration: 0.3, animations:{
                self.view.layoutIfNeeded();
            });
        }
        isSlideMenuHidden = !isSlideMenuHidden;
    }
}
