import UIKit
import JVFloatLabeledTextField
import iOSDropDown
import ObjectMapper
import RappleProgressHUD

class SignUpVC: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var tvEntity: JVFloatLabeledTextField!
    @IBOutlet weak var tvCommunity: JVFloatLabeledTextField!
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
    var pickOptionCommunity = ["Dealer", "Seller"]
    var pickOptionEntity = ["Company", "Indivisual"]
    
    var countryData:[CountryResponse.Data] = []
    let pickerView :UIPickerView = UIPickerView()
    let pickerViewCommunity :UIPickerView = UIPickerView()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if country_id == "IN"{
//            tvState.text == ""
            btnState.isHidden = false
            
        }else{
            btnState.isHidden = true
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         pickerView.delegate = self
        pickerViewCommunity.delegate = self
        
        ///
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.blue
        toolBar.sizeToFit()
        
        
        let cancelButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelTapped))
        
        toolBar.setItems([cancelButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        
        
        ///
        tvEntity.inputView = pickerView
        tvEntity.inputAccessoryView = toolBar
        
        
        tvCommunity.inputView = pickerViewCommunity
        tvCommunity.inputAccessoryView = toolBar
        
        
//        let pickerView = UIPickerView()
        
        self.getCountry(url: Endpoint.getCountryList.url)
      
        
    }
    @objc func cancelTapped() {
        tvEntity.resignFirstResponder()
         tvCommunity.resignFirstResponder()
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.pickerViewCommunity{
            return pickOptionCommunity.count
        }else{
            return pickOptionEntity.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.pickerViewCommunity{
            return pickOptionCommunity[row]
        }else{
            return pickOptionEntity[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         if pickerView == self.pickerViewCommunity{
            tvCommunity.text = pickOptionCommunity[row]
         }else{
            tvEntity.text = pickOptionEntity[row]
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == self.pickerViewCommunity{
            return 1
        }
        else{
            return 1
        }
        
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
    
    @IBAction func btnCrateAccount(_ sender: Any) {
        
        if ConnectionCheck.isConnectedToNetwork() {
            print("connected")
            if (tvFnm.text?.isEmpty)!{
                showAlert(title: "", message: "Please enter first name.")
            }else if (tvLnm.text?.isEmpty)!{
                showAlert(title: "", message: "Please enter last name.")
            }else if (tvEmail.text?.isEmpty)!{
                showAlert(title: "", message: "Please enter email.")
            }else if (tvContact.text?.isEmpty)!{
                showAlert(title: "", message: "Please enter contact no.")
            }
            else if (tvCommunity.text?.isEmpty)!{
                showAlert(title: "", message: "Please select community.")
            }
            
            else if (tvAddress.text?.isEmpty)!{
                showAlert(title: "", message: "Please enter address.")
            }else if (tvCity.text?.isEmpty)!{
                showAlert(title: "", message: "Please enter city.")
            }else if (tvZipCode.text?.isEmpty)!{
                showAlert(title: "", message: "Please enter zip code.")
            }
            
            else if (tvEntity.text?.isEmpty)!{
                showAlert(title: "", message: "Please select entity.")
            }
            
            else if (tvPwd.text?.isEmpty)!{
                showAlert(title: "", message: "Please enter password.")
            }else if (tvConfirmPwd.text?.isEmpty)!{
                showAlert(title: "", message: "Please enter confirm password.")
            }
            else{
                
                if selectCountry.text == ""{
                    self.showAlert(title: "", message: "Please select country.")
                }else{
                
                if country_id == "IN"{
                    
                    if region_id == ""{
                        showAlert(title: "", message: "Please select state.")
                    }else{
                         self.signUp(state: region_id)
                    }
                    
                }else{
                    if (tvState.text?.isEmpty)!{
                        showAlert(title: "", message: "Please enter state name.")
                    }else{
                        self.signUp(state: tvState.text!)
                    }
                    
                }
                    
                }
                
                
            }
//            else if (tvConfirmPwd.text?.isEmpty)! == (tvConfirmPwd.text?.isEmpty)!) {
            
//            }
        }
        
    }
    
    @IBAction func btnSelectCountry(_ sender: Any) {
        let country=self.storyboard?.instantiateViewController(withIdentifier: "SelectCountryVC") as! SelectCountryVC
        country.arrCountry = countryData
        country.myCompletion = { sdas, ds in
            print(sdas)
            self.country_name = sdas
            self.country_id = ds
            self.selectCountry.text = self.country_name
            
            if self.country_id == "IN" {
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
    
    func signUp(state:String) {
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        
        let par = ["firstname": self.tvFnm.text!,
                   "lastname": self.tvLnm.text!,
                   "email": self.tvEmail.text!,
                   "contact_number": self.tvContact.text!,
                   "community": tvCommunity.text!,
                   "street": self.tvAddress.text!,
                   "country_id": country_id,
                   "region": state,
                   "city": self.tvCity.text!,
                   "postcode": self.tvZipCode.text!,
                   "entity_customer": self.tvEntity.text!,
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
