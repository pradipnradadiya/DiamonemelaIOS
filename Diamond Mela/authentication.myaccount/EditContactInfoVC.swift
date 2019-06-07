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
        if let dataArrayString = (UserDefaults.standard.string(forKey: USER_SESSION_DATA_KEY)) {
            
            if let dataObject = Mapper<LoginItem>().map(JSONString: dataArrayString)  {
                
                self.tvFnm.text=dataObject.data?.firstname
                self.tvLnm.text=dataObject.data?.lastname
                self.tvEmail.text=dataObject.data?.email
                self.tvContact.text=dataObject.data?.telephone
                self.tvAddress.text=dataObject.data?.street
                self.tvCity.text=dataObject.data?.city
                self.tvZipCode.text=dataObject.data?.postcode
                //self.tvPancardNo.text=dataObject.data?.p
//                self.tvGstin.text=dataObject.data?._isfranchisee
                
                
                
            }
        }
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
    let par = ["notification_token": "SDFSDFDS664564",
               "customer_id": customerId,
               "firstname": tvFnm.text!,
               "lastname": tvLnm.text!,
               "email": tvEmail.text!,
               "contact_number": tvContact.text!,
               "street": tvAddress.text!,
               "country_id": "IN",
               "region": "491",
               "city": tvCity.text!,
               "postcode": tvZipCode.text!,
               "pancardno": tvPancardNo.text!,
               "gstin": tvGstin.text!]
        
    RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
    ApiManager.shared.apiEditContactInfo(params:par as [String : AnyObject]) { (result) in
    
    RappleActivityIndicatorView.stopAnimation()
    
    let status = result[STATUS_CODE] as? String
    print(status as Any)
    if status == FAILURE_CODE || status == nil {
        
    } else {
        
        // create the alert
        let alert = UIAlertController(title: "Success", message: "Information edit successfully.", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: { action in
            self.navigationController?.popViewController(animated: true)
            
        }))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
       
    }
    
    }
        
    }
    
}
