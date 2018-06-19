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
    @IBOutlet weak var sideMenuLeading: NSLayoutConstraint!
    @IBOutlet weak var sideMenuTrailing: NSLayoutConstraint!
    
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
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            print("Ok")
            let userDef = UserDefaults.standard;
            userDef.removeObject(forKey: "userId");
            userDef.removeObject(forKey: "isLoggedIn")
            print("after remove id: \(userDef.object(forKey: "userId"))")
            print("after remove isLoggedIn: \(userDef.object(forKey: "isLoggedIn"))")
            
            let loginView = self.storyboard?.instantiateViewController(withIdentifier: "loginVC");
            self.present(loginView!, animated: true, completion: nil);
        });
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil);
        let alertActions = [okAction, cancelAction];
        
        CommonMethods.showAlert(base: self, actions: alertActions , alertTitle: "Logout", alertMsg: "Are you sure you want to logout ?")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("width in didLoad: \(UIScreen.main.bounds.width)");
        sideMenuLeading.constant = -177;
        sideMenuTrailing.constant = -1 * (UIScreen.main.bounds.width);
        sideMenuButtons = [statisticsBtn, vehiclesBtn, historyBtn, settingsBtn, aboutBtn, logoutBtn];
        
        let gesture = UITapGestureRecognizer(target: self, action: "wholeViewAction:");
        self.wholeView.addGestureRecognizer(gesture);
    }

    @objc func wholeViewAction(_ sender:UITapGestureRecognizer) {
        if (isSlideMenuHidden == false) {
            sideMenuLeading.constant = -177;
            sideMenuTrailing.constant = -1 * (UIScreen.main.bounds.width);
            UIView.animate(withDuration: 0.3, animations:{
                self.view.layoutIfNeeded();
            });
            isSlideMenuHidden = true;
        }
    }
    
    @IBAction func showMenu(_ sender: Any) {
        if isSlideMenuHidden {
            print("trailing: \(UIScreen.main.bounds.width - ((UIScreen.main.bounds.width)/3))");
            sideMenuLeading.constant = 0;
//            sideMenuTrailing.constant = -100;
            sideMenuTrailing.constant = -1 * (UIScreen.main.bounds.width - ((UIScreen.main.bounds.width)/2.5));

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
            sideMenuLeading.constant = -177;
            sideMenuTrailing.constant = -1 * (UIScreen.main.bounds.width);
            UIView.animate(withDuration: 0.3, animations:{
                self.view.layoutIfNeeded();
            });
        }
        isSlideMenuHidden = !isSlideMenuHidden;
    }
}
