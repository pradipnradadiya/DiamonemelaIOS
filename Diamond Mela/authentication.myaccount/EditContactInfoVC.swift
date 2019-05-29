import UIKit
import ObjectMapper
import RappleProgressHUD
import JVFloatLabeledTextField

class EditContactInfoVC: UIViewController {

    @IBOutlet weak var btnState: UIButton!
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var tvState: JVFloatLabeledTextField!
    @IBOutlet weak var tvGstin: JVFloatLabeledTextField!
    @IBOutlet weak var tvPancardNo: JVFloatLabeledTextField!
    @IBOutlet weak var tvZipCode: JVFloatLabeledTextField!
    @IBOutlet weak var tvCity: JVFloatLabeledTextField!
    @IBOutlet weak var tvAddress: JVFloatLabeledTextField!
    @IBOutlet weak var tvContact: JVFloatLabeledTextField!
    @IBOutlet weak var tvEmail: JVFloatLabeledTextField!
    @IBOutlet weak var tvLnm: JVFloatLabeledTextField!
    @IBOutlet weak var tvFnm: JVFloatLabeledTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnSelectState(_ sender: Any) {
    }
    @IBAction func btnSave(_ sender: Any) {
    }
    @IBAction func btnCart(_ sender: Any) {
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSelectCountry(_ sender: Any) {
    }
    @IBAction func btnSearch(_ sender: Any) {
    }
}

extension EditContactInfoVC{
    
    
    func getCountry(url : String){
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiGetCountry(url: url){ (result) in
            RappleActivityIndicatorView.stopAnimation()
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                
            }
            
        }
    }
    
    func getState(url : String){
        let par = ["country_id": "countryId"]
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiGetState(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
                
            } else {
                
                
            }
            
        }
    }
    
    
    
    
    func editContactInfo(){
    let par = ["notification_token": "",
               "customer_id": "",
               "firstname": "",
               "lastname": "",
               "email": "",
               "contact_number": "",
               "street": "",
               "country_id": "",
               "region": "",
               "city": "",
               "postcode": "",
               "pancardno": "",
               "gstin": ""]
    RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
    ApiManager.shared.apiEditContactInfo(params:par as [String : AnyObject]) { (result) in
    
    RappleActivityIndicatorView.stopAnimation()
    
    let status = result[STATUS_CODE] as? String
    print(status as Any)
    if status == FAILURE_CODE || status == nil {
    
    
    } else {
    
    }
    
    }
        
    }
    
}
