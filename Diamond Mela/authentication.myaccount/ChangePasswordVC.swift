import UIKit
import ObjectMapper
import RappleProgressHUD

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var tvConfirmPassword: UITextField!
    @IBOutlet weak var tvNewPassword: UITextField!
    @IBOutlet weak var tvOldPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnChangePassword(_ sender: Any) {
        if (tvOldPassword.text?.isEmpty)!{
            showAlert(title: "", message: "Please enter old password.")
        }else if (tvNewPassword.text?.isEmpty)!{
            showAlert(title: "", message: "Please enter new password.")
        }else if (tvConfirmPassword.text?.isEmpty)!{
            showAlert(title: "", message: "Please enter confirm password.")
        }
        else if (tvNewPassword.text != tvConfirmPassword.text){
            showAlert(title: "", message: "confirm password not same as new password.")
        }
        
        else{
            self.changePassword(oldPassword: tvOldPassword.text!, newPassword: tvNewPassword.text!, confirmPassword: tvConfirmPassword.text!)
        }
    
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ChangePasswordVC{
    
    func changePassword(oldPassword:String,newPassword:String,confirmPassword:String)  {
        
        let par = ["customer_id": customerId,
                   "current_password":oldPassword,
                   "new_password":newPassword]
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiChangePassword(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
                
            } else {
                // create the alert
                let alert = UIAlertController(title: "Success", message: "Password changed successfully", preferredStyle: UIAlertController.Style.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: { action in
                    let login = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
                    self.navigationController?.pushViewController(login!, animated: true)
                    
                    
                }))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
                
                
                
              
                
            }
            
        }
        
    }
    
}
