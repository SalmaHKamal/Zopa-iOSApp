 
import UIKit
import Toast_Swift
 
//import FacebookLogin
class LoginViewController: UIViewController {

   
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    var ifExist : String?
    let  userDefaults = UserDefaults.standard
    
    @IBAction func registerAction(_ sender: Any) {
        let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "registerVC")
        self.present(registerVC!, animated: true, completion: nil)
    }
    @IBAction func loginAction(_ sender: Any) {
        
        
        guard let password = passwordTxt.text , !password.isEmpty else{
            self.view.makeToast("enter your password", duration: 3.0, position: .bottom)
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
        
        ifExist = UserDAO.getInstance().isUser(email: emailTxt.text!, password: passwordTxt.text!)
     
        
//        ifExist = userDefaults.object(forKey: "userId")
        
        print("after exist")
        
        if ifExist != nil {
            print("loged")
            saveInUserDefaults()
            goToHome()
        }else{
            print("not allowed login")
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil);
            let alertActions = [okAction];
            CommonMethods.showAlert(base: self, actions: alertActions, alertTitle: "Not Allowed", alertMsg: "check you name and password and login again");
        }
    }
    
    func goToHome(){
        print("from go to home")
        perform(#selector(showHome), with: nil, afterDelay: 2)
    }
    
    func saveInUserDefaults(){
    
        userDefaults.setValue(self.ifExist, forKeyPath: "userId")
        userDefaults.setValue(true, forKeyPath: "isLoggedIn")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc func showHome(){
        performSegue(withIdentifier: "showHomeFromLogin", sender: self)
    }
    
    


}
