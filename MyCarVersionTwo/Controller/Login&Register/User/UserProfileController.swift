//
//  UserProfileController.swift
//  MyCarVersionTwo
//
//  Created by Sayed Abdo on 5/25/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import DropDown
import Toast_Swift

class UserProfileController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var genderButtonOutlt: UIButton!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var addressTxt: UITextField!
    @IBOutlet weak var mobileTxt: UITextField!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var chooserOutlt: UISwitch!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveChangesBtn: UIButton!
    
    
    let dropDown = DropDown()
    var imagePicker = UIImagePickerController()
    var user : User?
    let userInstance = UserDAO.getInstance();
    
    
    @IBAction func genderAction(_ sender: UIButton) {
        dropDown.show()
    }
    
    @IBAction func forgetAction(_ sender: UIButton) {
        
    }
    
    @IBAction func chooserAction(_ sender: Any) {
        if chooserOutlt.isOn {
            chooserOutlt.setOn(false, animated:true)
            saveChangesBtn.isHidden = true
            
        } else {
            chooserOutlt.setOn(true, animated:true)
            saveChangesBtn.isHidden = false
        }
    }
    
    @IBAction func btnClicked(_: UIButton) {
        showPicker()
    }
    
    @IBAction func editUserData(_ sender: UIButton) {
        
        let userTemp = User();
        userTemp.name = nameTxt.text!
        userTemp.email = emailTxt.text!
        userTemp.mobile = mobileTxt.text!
        userTemp.gender = genderLbl.text!
        userTemp.address = addressTxt.text!
        userTemp.id = (user?.id)!
        
        userInstance.updateUserData(newUserData: userTemp);
        self.view.makeToast("Your Info has been Updated Successfully", duration: 3.0, position: .center);
        chooserOutlt.setOn(false, animated:true);
        saveChangesBtn.isHidden = true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveChangesBtn.isHidden = true
        dropDownSetUp()
        chooserSetUp()
        setUpUserData()
        closeEditing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //salma
        setUpUserData()
    }
}

// MARK: - image picker methods
extension UserProfileController{
    
    func showPicker()  {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("choosed image");
        let chosenImage: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage; //2
        imageView.image = chosenImage;
        
        var imgData:Data?
        let assetPath = info[UIImagePickerControllerReferenceURL] as! NSURL;
        if (assetPath.absoluteString?.hasSuffix("JPG"))! {
            print("JPG");
            imgData = UIImageJPEGRepresentation(chosenImage, 1.0);
        }
        else if (assetPath.absoluteString?.hasSuffix("PNG"))! {
            print("PNG");
            imgData = UIImagePNGRepresentation(chosenImage)!;
        }
    
        userInstance.saveProfilePic(imgData: imgData!, userId: (user?.id)!);
        self.dismiss(animated: true, completion: { () -> Void in
        });
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Table view data source
extension UserProfileController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func setUpUserData() {
        let defaults = UserDefaults.standard
        let userId = defaults.value(forKey: "userId")
        user = UserDAO.getInstance().getUserByID(userId: userId as! String)
        imageView.image = UIImage(data: (user?.profilePic)!);
    }
}
// MARK: - Drop Down Methods
extension UserProfileController{

    func dropDownSetUp(){
        dropDown.anchorView = genderLbl
        dropDown.dataSource = ["Male", "Female"]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.dropDown.hide()
            self.genderLbl.text = item
        }
    }
}

// MARK: - chooser Methods
extension UserProfileController{
    
    func chooserSetUp(){
        chooserOutlt.addTarget(self, action: #selector(stateChanged(switchState:)), for: UIControlEvents.valueChanged)
        }
    
    @objc func stateChanged(switchState: UISwitch) {
        if switchState.isOn {
            openEditing()
            print("opened")
        } else {
            closeEditing()
            print("closed")
        }
    }
    
    func openEditing() {
        self.nameTxt.isUserInteractionEnabled = true
        self.addressTxt.isUserInteractionEnabled = true
        self.mobileTxt.isUserInteractionEnabled = true
        self.emailTxt.isUserInteractionEnabled = true
        self.genderButtonOutlt.isEnabled = true
    }
    
    func closeEditing() {
        self.nameTxt.text = user?.name
        self.addressTxt.text = user?.address
        self.mobileTxt.text = user?.mobile
        self.emailTxt.text = user?.email
        self.genderLbl.text=user?.gender
        //let img = UIImage(data: (user?.profilePic)!);
        //self.imageView.image = img;
        
        self.nameTxt.isUserInteractionEnabled = false
        self.addressTxt.isUserInteractionEnabled = false
        self.mobileTxt.isUserInteractionEnabled = false
        self.emailTxt.isUserInteractionEnabled = false
        self.genderButtonOutlt.isEnabled=false
        
    }
    
}

