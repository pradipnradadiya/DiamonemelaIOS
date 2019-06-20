import UIKit
import JVFloatLabeledTextField
import ObjectMapper
import RappleProgressHUD

class ContactUsVC: UIViewController {

    @IBOutlet weak var tvComment: JVFloatLabeledTextField!
    @IBOutlet weak var tvTeliphone: JVFloatLabeledTextField!
    @IBOutlet weak var tvEmail: JVFloatLabeledTextField!
    @IBOutlet weak var tvName: JVFloatLabeledTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    @IBAction func btnSubmit(_ sender: Any) {
        
        if (tvComment.text?.isEmpty)!{
            showAlert(title: "", message: "Please enter comment.")
        }else if (tvTeliphone.text?.isEmpty)!{
            showAlert(title: "", message: "Please enter telephone.")
        }else if (tvEmail.text?.isEmpty)!{
            showAlert(title: "", message: "Please enter email.")
        }else if (tvName.text?.isEmpty)!{
            showAlert(title: "", message: "Please enter name.")
        }else{
            self.saveContactUs(name: tvName.text!, email: tvEmail.text!, telephone: tvTeliphone.text!, comment: tvComment.text!)
        }
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ContactUsVC{
    func saveContactUs(name:String,email:String,telephone:String,comment:String) {
        
        let par = ["name": name,
                   "comment": comment,
                   "email": email]
        
        
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiContactUs(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                let msg=result["message"] as? String
                self.showAlert(title: SUCCESS, message: msg!)
            }
            
        }
        
    }
}
