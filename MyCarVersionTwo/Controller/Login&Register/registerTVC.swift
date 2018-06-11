//
//  registerTVC.swift
//  MyCarVersionTwo
//
//  Created by Sayed Abdo on 6/5/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import DropDown
import Realm

class registerTVC: UITableViewController {

    
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var mobileTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var addressTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var confiemPassTxt: UITextField!
    @IBOutlet var registerTableView: UITableView!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBAction func genderAction(_ sender: Any) {
        dropDown.show()
    }
    
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDownSetUp();
        
        registerBtn.layer.cornerRadius = 5;
        cancelBtn.layer.cornerRadius = 5;
        
        /*let img = UIImage(named: "bg");
        let imageViewBackground = UIImageView(image: img);
        self.registerTableView.backgroundView = imageViewBackground;*/
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 9;
    }
    
    /*override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath);
        myCell.layer.backgroundColor = UIColor.clear.cgColor;
        let img = UIImage(named: "bg");
        myCell.backgroundView = UIImageView(image: img);
        return myCell;
    }*/

    
    @IBAction func cancelAction(_ sender: UIButton) {
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginVC");
        self.present(loginVC!, animated: true, completion: nil);
    }
    
    @IBAction func registerBtn(_ sender: Any) {
        
        guard let username = nameTxt.text?.trimmingCharacters(in: .whitespaces) , !username.isEmpty else {
            self.view.makeToast("enter user name", duration: 3.0, position: .bottom)
            return
        }
        
        guard let password = passwordTxt.text , !password.isEmpty else{
            self.view.makeToast("enter your password", duration: 3.0, position: .bottom)
            return
        }
        
        guard let confirmpassword = confiemPassTxt.text , confirmpassword == password  else{
            self.view.makeToast("password not matched", duration: 3.0, position: .bottom)
            return
        }
        
        
        guard let email = emailTxt.text?.trimmingCharacters(in: .whitespaces) , !email.isEmpty else{
            
            self.view.makeToast("Enter Email", duration: 3.0, position: .bottom)
            
            return
        }
        
        guard Validator.isValidEmail(testStr: email) == true else{
            self.view.makeToast("Enter valid Email", duration: 3.0, position: .bottom)
            return
        }
        
        guard let gender = genderLbl.text?.trimmingCharacters(in: .whitespaces) , !gender.isEmpty else {
            self.view.makeToast("select gender", duration: 3.0, position: .bottom)
            return
        }
        
        guard let address = addressTxt.text?.trimmingCharacters(in: .whitespaces) , !address .isEmpty else {
            self.view.makeToast("enter address", duration: 3.0, position: .bottom)
            return
        }
        
        let user : User = User(userNameVal: nameTxt.text!,
                               userEmailVal: emailTxt.text!,
                               userPasswordVal: passwordTxt.text!,
                               userGenderVal: genderLbl.text!,
                               userMobVal: mobileTxt.text!,
                               userPicVal: "".data(using: .utf8)! as Data, address: addressTxt.text!)
        
        UserDAO.getInstance().insertUser(userObj: user)
        
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginVC")
        self.present(loginVC!, animated: true, completion: nil)
    }
}

// MARK: - Drop Down Methods
extension registerTVC{
    
    func dropDownSetUp(){
        dropDown.anchorView = genderLbl
        dropDown.dataSource = ["Male", "Female"]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.dropDown.hide()
            self.genderLbl.text = item
        }
    }
}
