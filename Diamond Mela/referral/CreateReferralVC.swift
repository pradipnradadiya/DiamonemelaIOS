import UIKit
import ObjectMapper
import RappleProgressHUD
import JVFloatLabeledTextField

class CreateReferralVC: UIViewController {

    @IBOutlet weak var tvDiscount: JVFloatLabeledTextField!
    @IBOutlet weak var tvTel: JVFloatLabeledTextField!
    @IBOutlet weak var tvEmail: JVFloatLabeledTextField!
    @IBOutlet weak var tvLnm: JVFloatLabeledTextField!
    @IBOutlet weak var tvFnm: JVFloatLabeledTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCart(_ sender: Any) {
    }
    @IBAction func btnSearch(_ sender: Any) {
    }
    @IBAction func btnManageReferral(_ sender: Any) {
    }
    
    @IBAction func btnAddReferral(_ sender: Any) {
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension CreateReferralVC{
    
    func createReferral() {
        let par = ["franchisee_status": "",
                   "firstname": "firstname",
                   "lastname": "",
                   "email": "",
                   "group_id": "",
                   "password": "",
                   "referral_comission": "",
                   "parent_franchise_id": "",
                   "telephone": "",
                   "referral_type": "",
                   "_isfranchisee":""]
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiCreateReferral(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
                
            } else {
                
            }
            
        }
    }
    
}
