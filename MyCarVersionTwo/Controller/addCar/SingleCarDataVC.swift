//
//  SingleCarDataVC.swift
//  MyCarVersionTwo
//
//  Created by Sayed Abdo on 5/24/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit


class SingleCarDataVC: UITableViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    
    //outlets
    @IBOutlet weak var carImgView : UIImageView!
    @IBOutlet weak var carNameField: UITextField!
    @IBOutlet weak var carModelField: UITextField!
    @IBOutlet weak var carYearField: UITextField!
    @IBOutlet weak var carDescField: UITextView!
    
    //variables
    var singleCar : Car?
    var delegate : updateCarListTableProtocol?
    let carInstance = CarDAO.getInstance()
    var imgData:Data?
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let car = singleCar {
            
            let image = UIImage(data : (car.image))
            carImgView.image = image
            carNameField.text = car.name
            carModelField.text = car.model
            carYearField.text = car.year
            carDescField.text = car.desc
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated : true , completion : nil)
    }
    
    func imagePickerController(_ picker : UIImagePickerController , didFinishPickingMediaWithInfo info: [String : Any]){

        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        carImgView.image =  image 
        
        let assetPath = info[UIImagePickerControllerReferenceURL] as! NSURL;
        if (assetPath.absoluteString?.hasSuffix("JPG"))! {
            print("JPG");
            imgData = UIImageJPEGRepresentation(image, 1.0);
        }
        else if (assetPath.absoluteString?.hasSuffix("PNG"))! {
            print("PNG");
            imgData = UIImagePNGRepresentation(image)!;
        }
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func testBtn(_ sender: Any){
        print("salma")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker , animated: true , completion : nil)
    }
  
    @IBAction func saveCarDetails(_ sender: Any) {
        
        let userDef = UserDefaults.standard;
        let userId: String = userDef.value(forKey: "userId") as! String;
        
        let newSingleCar = Car(carNameVal: carNameField.text!,
                               carModelVal: carModelField.text!,
                               carYearVal: carYearField.text!,
                               carDescVal: carDescField.text)
        if let newimgData = imgData{
            newSingleCar.image = newimgData
        }
        if let carvar = singleCar {
            newSingleCar.id = carvar.id
            //update car value in db
            CarDAO.getInstance().updateCar(newCarData: newSingleCar)
        } else{
            if let newimgData = imgData{
                newSingleCar.image = newimgData
            }
            CarDAO.getInstance().insertCar(carObj: newSingleCar)
            let user_Obj = UserDAO.getInstance().getUserByID(userId: userId)
            UserDAO.getInstance().addCarForUser(newCar: newSingleCar, userObj: user_Obj!)
            delegate?.updateTableValues(newCar: newSingleCar)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    

}
