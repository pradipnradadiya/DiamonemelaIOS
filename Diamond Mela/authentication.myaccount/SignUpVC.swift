import UIKit
import JVFloatLabeledTextField
import iOSDropDown
import ObjectMapper
import RappleProgressHUD

class SignUpVC: UIViewController {

    @IBOutlet weak var btnState: UIButton!
    @IBOutlet weak var selectCountry: JVFloatLabeledTextField!
    @IBOutlet weak var tvLnm: JVFloatLabeledTextField!
    @IBOutlet weak var tvFnm: JVFloatLabeledTextField!
    @IBOutlet weak var tvEmail: JVFloatLabeledTextField!
    @IBOutlet weak var tvContact: JVFloatLabeledTextField!
    @IBOutlet weak var tvAddress: JVFloatLabeledTextField!
    @IBOutlet weak var tvState: JVFloatLabeledTextField!
    @IBOutlet weak var tvCity: JVFloatLabeledTextField!
    @IBOutlet weak var tvZipCode: JVFloatLabeledTextField!
    @IBOutlet weak var tvCompanyName: JVFloatLabeledTextField!
    @IBOutlet weak var tvPwd: JVFloatLabeledTextField!
    @IBOutlet weak var tvConfirmPwd: JVFloatLabeledTextField!
    
    var country_id:String = ""
    var country_name:String = ""
    var region_id:String = ""
    var region_name:String = ""
    
    var countryData:[CountryResponse.Data] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

             
        
      //  self.getCountry(url: Endpoint.getCountryList.url)
        
                
        // The list of array to display. Can be changed dynamically
        
      
        // Do any additional setup after loading the view.
                
        
    }
    
    @IBAction func btnSelectState(_ sender: Any) {
        let state=self.storyboard?.instantiateViewController(withIdentifier: "SelectStateVC") as! SelectStateVC
        state.countryId = country_id
        state.myCompletion = { sdas, ds in
            print(sdas)
            self.region_name = sdas
            self.region_id = ds
            self.tvState.text = self.region_name
        }
        self.navigationController?.pushViewController(state, animated: true)
    }
    
    
    @IBAction func btnSelectCountry(_ sender: Any) {
        let country=self.storyboard?.instantiateViewController(withIdentifier: "SelectCountryVC") as! SelectCountryVC
        country.arrCountry = countryData
        country.myCompletion = { sdas, ds in
            print(sdas)
            self.country_name = sdas
            self.country_id = ds
            self.selectCountry.text = self.country_name
            
            if self.country_id == "IN"{
                self.btnState.isHidden = false
            }else{
                self.btnState.isHidden = true
            }
      
        }
        self.navigationController?.pushViewController(country, animated: true)
        
    }
    
    @IBAction func itemBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTermsCondition(_ sender: Any) {
        let terms=self.storyboard?.instantiateViewController(withIdentifier: "TermsConditionVC") as! TermsConditionVC
        self.navigationController?.pushViewController(terms, animated: true)
    }
    
    
    @IBAction func btnCheckUncheck(_ sender: UIButton) {
        if sender.isSelected {
            sender.setImage(UIImage(named: "checked"), for: .normal)
            sender.isSelected=false
        }else{
            sender.setImage(UIImage(named: "unchecked"), for: .normal)
            sender.isSelected=true
        }
    }
}

extension SignUpVC{
    
    func signUp() {
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        
        let par = ["firstname": self.tvFnm.text!,
                   "lastname": self.tvLnm.text!,
                   "email": self.tvEmail.text!,
                   "contact_number": self.tvContact.text!,
                   "community": "Dealer",
                   "street": self.tvAddress.text!,
                   "country_id": country_id,
                   "region": region_id,
                   "city": self.tvCity.text!,
                   "postcode": self.tvZipCode.text!,
                   "entity_customer": self.tvEmail.text!,
                   "password": self.tvPwd.text!,
                   "confirmation": self.tvConfirmPwd.text!]
        
        ApiManager.shared.apiSignUp(params:par as [String : AnyObject]) { (result) in
            
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
    
    
    func getCountry(url : String){
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiGetCountry(url: url){ (result) in
            RappleActivityIndicatorView.stopAnimation()
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                let countryList=Mapper<CountryResponse>().map(JSON: result)
                
                self.countryData=(countryList?.data)!
                
               
                
            }
            
        }
    }
    
    func getState(country_id : String){
        let par = ["country_id": country_id]
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiGetState(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
                
            } else {
                let stateList=Mapper<StateResponse>().map(JSON: result)
                
                
            }
            
        }
    }
}
