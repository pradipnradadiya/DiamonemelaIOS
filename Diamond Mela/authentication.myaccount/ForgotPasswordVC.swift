import UIKit
import RappleProgressHUD

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var tvEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func itemBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnResetPassword(_ sender: Any) {
        if ConnectionCheck.isConnectedToNetwork() {
            if (tvEmail.text?.isEmpty)!{
                showAlert(title: "", message: "Please enter email.")
            }else{
                forgorPassword()
            }
            
        }else{
            print("disconnected")
            showAlert(title: internetAlert, message: internetNotConnectMsg!)
        }
    }
    
}

extension ForgotPasswordVC {
    
    func forgorPassword() {
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        
        let par = ["email": self.tvEmail.text!]
        
        ApiManager.shared.apiForgotPassword(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            
            if status == FAILURE_CODE || status == nil {
                self.showAlert(title: errorTitle, message: wrongLogin)
            } else {
                let message:String=result["message"] as? String ?? ""
                self.successPopup(title: SUCCESS,msg: message)
                
                print("success")
                
                
            }
            
        }
        
    }
    
}

