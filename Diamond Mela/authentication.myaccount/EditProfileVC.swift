import UIKit
import ObjectMapper
import RappleProgressHUD
import JVFloatLabeledTextField

class EditProfileVC: UIViewController {
    
    @IBOutlet weak var tvBranchName: JVFloatLabeledTextField!
    @IBOutlet weak var tvIfscCode: JVFloatLabeledTextField!
    @IBOutlet weak var tvBankAccountHolderName: JVFloatLabeledTextField!
    @IBOutlet weak var tvBankAccountNumber: JVFloatLabeledTextField!
    @IBOutlet weak var tvBankName: JVFloatLabeledTextField!
    @IBOutlet weak var lblReferralCode: UILabel!
    @IBOutlet weak var lblDefaultShippingTel: UILabel!
    @IBOutlet weak var lblDefaultShippingCountry: UILabel!
    @IBOutlet weak var lblDefaultShippingCityState: UILabel!
    @IBOutlet weak var lblDefaultShippingAddress: UILabel!
    @IBOutlet weak var lblDefaultShippingName: UILabel!
    @IBOutlet weak var lblDefaultBillingTel: UILabel!
    @IBOutlet weak var lblDefaultBillingCountry: UILabel!
    @IBOutlet weak var lblDefaultBillingCityState: UILabel!
    @IBOutlet weak var lblDefaultBillingAddress: UILabel!
    @IBOutlet weak var lblDefaultBillingName: UILabel!
    @IBOutlet weak var lblContactInfoEmail: UILabel!
    @IBOutlet weak var lblContactInfoName: UILabel!
    
    var addressData : AddressManageResponse?
    
    override func viewWillAppear(_ animated: Bool) {
       
        if let dataArrayString = (UserDefaults.standard.string(forKey: USER_SESSION_DATA_KEY)) {
            
            if let dataObject = Mapper<LoginItem>().map(JSONString: dataArrayString)  {
                self.lblContactInfoName.text="\(dataObject.data?.firstname ?? "") \(dataObject.data?.lastname ?? "")"
                self.lblContactInfoEmail.text=dataObject.data?.email
                self.lblReferralCode.text=dataObject.data?.refcode
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAllAddress()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnChangePassword(_ sender: Any) {
        /*
        let alert = UIAlertController(title: "Change Password", message: nil, preferredStyle: .alert)
        
        alert.addTextField {
            $0.placeholder = "Old Password"
            $0.isSecureTextEntry = true
            $0.addTarget(alert, action: #selector(alert.textDidChangeInLoginAlert), for: .editingChanged)
        }
        
        alert.addTextField {
            $0.placeholder = "New Password"
            $0.isSecureTextEntry = true
            $0.addTarget(alert, action: #selector(alert.textDidChangeInLoginAlert), for: .editingChanged)
        }
        
        alert.addTextField {
            $0.placeholder = "Confirm Password"
            $0.isSecureTextEntry = true
            $0.addTarget(alert, action: #selector(alert.textDidChangeInLoginAlert), for: .editingChanged)
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        let loginAction = UIAlertAction(title: "Submit", style: .default) { [unowned self] _ in
            guard let password = alert.textFields?[0].text,
                let password1 = alert.textFields?[1].text,
                let password2 = alert.textFields?[2].text
                else { return } // Should never happen
            
            // Perform login action
        }
        
        loginAction.isEnabled = false
        alert.addAction(loginAction)
        present(alert, animated: true)*/
        
    }
    
    @IBAction func btnContactInformationEdit(_ sender: Any) {
    }
    
    @IBAction func btnDefaultShippingAddressEdit(_ sender: Any) {
        let address = self.storyboard?.instantiateViewController(withIdentifier: "EditAddressVC") as? EditAddressVC
        address?.status="2"
        address?.defaultShipping = addressData?.default_shipping
        self.navigationController?.pushViewController(address!, animated: true)
    }
    
    @IBAction func btnDefaultBillingAddressEdit(_ sender: Any) {
        let address = self.storyboard?.instantiateViewController(withIdentifier: "EditAddressVC") as? EditAddressVC
        address?.status="1"
        address?.defaultBilling = addressData?.default_billing
        self.navigationController?.pushViewController(address!, animated: true)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
    }
    
    @IBAction func btnSave(_ sender: Any) {
        
        self.addBank()
    }
    
    @IBAction func btnAddBankDetail(_ sender: Any) {
    }
    
    @IBAction func btnManageAddress(_ sender: Any) {
        print("manage address")
        let address = self.storyboard?.instantiateViewController(withIdentifier: "ManageAddressVC") as? ManageAddressVC
        self.navigationController?.pushViewController(address!, animated: true)
        
    }
    
    @IBAction func btnManageBank(_ sender: Any) {
        let address = self.storyboard?.instantiateViewController(withIdentifier: "ManageBankVC") as? ManageBankVC
        self.navigationController?.pushViewController(address!, animated: true)
    }
    
    @IBAction func btnCart(_ sender: Any) {
    }
    
    @IBAction func btnSearch(_ sender: Any) {
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
}

extension EditProfileVC {
    
    func getAllAddress() {
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        
        let par = ["customer_id": customerId]
        
        ApiManager.shared.apiGetAllAddress(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            
            if status == FAILURE_CODE || status == nil {
                self.showAlert(title: errorTitle, message: wrongLogin)
            } else {
                //                 let loginData = Mapper<LoginItem.Data>().mapArray(JSONArray: result["data"] as! [[String : Any]])
                self.addressData = Mapper<AddressManageResponse>().map(JSON: result)
                print(self.addressData?.default_billing?.country as Any)
                print(self.addressData?.default_shipping?.country as Any)
                
                
                
                //--------Default Billing---------
                self.lblDefaultBillingName.text="\(self.addressData?.default_billing?.firstname ?? "") \(self.addressData?.default_billing?.lastname ?? "")"
                self.lblDefaultBillingAddress.text=self.addressData?.default_billing?.street
                self.lblDefaultBillingCityState.text="\(self.addressData?.default_billing?.city ?? "") \(", "+(self.addressData?.default_billing?.region)! ) \(", "+(self.addressData?.default_billing?.postcode)! )"
                
                self.lblDefaultBillingCountry.text=self.addressData?.default_billing?.country
                self.lblDefaultBillingTel.text=self.addressData?.default_billing?.telephone
                
                //-------Default Shipping------------
                self.lblDefaultShippingName.text="\(self.addressData?.default_shipping?.firstname ?? "") \(self.addressData?.default_billing?.lastname ?? "")"
                self.lblDefaultShippingAddress.text=self.addressData?.default_shipping?.street
                self.lblDefaultShippingCityState.text="\(self.addressData?.default_shipping?.city ?? "") \(", "+(self.addressData?.default_shipping?.region)! ) \(", "+(self.addressData?.default_shipping?.postcode)! )"
                
                self.lblDefaultShippingCountry.text=self.addressData?.default_shipping?.country
                self.lblDefaultShippingTel.text=self.addressData?.default_shipping?.telephone
                
                
                
                
                let addtionalData=Mapper<AddressManageResponse.Data>().mapArray(JSONArray: result["data"] as! [[String : Any]])
                print(addtionalData[0].country_id as Any)
                print("success")
              //  self.addBank()
               
            }
            
        }
        
    }
    
    func addBank () {
        
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        
        let par = ["customer_id": customerId,
                   "bank_name":self.tvBankName.text!,
                   "bank_account_number":self.tvBankAccountNumber.text!,
                   "bank_account_holder":self.tvBankAccountHolderName.text!,
                   "ifsc_code":self.tvIfscCode.text!,
                   "branch_name":self.tvBranchName.text!]
        
        ApiManager.shared.apiAddBankDetail(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                self.showAlert(title: errorTitle, message: wrongLogin)
                
            } else {
               self.showAlert(title: SUCCESS, message: "Bank Detail Added Successfully.")
            }
            
        }
        
    }
    
    
}
