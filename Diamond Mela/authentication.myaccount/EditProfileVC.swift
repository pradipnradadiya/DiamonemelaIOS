import UIKit
import ObjectMapper
import RappleProgressHUD
import JVFloatLabeledTextField

class EditProfileVC: UIViewController {
    
    @IBOutlet weak var viewBank: UIView!
    @IBOutlet weak var constraintBankView: NSLayoutConstraint!
    @IBOutlet weak var constraintFullHeight: NSLayoutConstraint!
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
        
       getDownloadCartCount()
        
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
        viewBank.isHidden = true
        constraintBankView.constant = 0
        constraintFullHeight.constant = 800
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnChangePassword(_ sender: Any) {
        
        let pwd = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as? ChangePasswordVC
        self.navigationController?.pushViewController(pwd!, animated: true)
        
       
        
    }
    
    @IBAction func btnContactInformationEdit(_ sender: Any) {
        let address = self.storyboard?.instantiateViewController(withIdentifier: "EditContactInfoVC") as? EditContactInfoVC
        self.navigationController?.pushViewController(address!, animated: true)
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
        viewBank.isHidden = true
        constraintBankView.constant = 0
        constraintFullHeight.constant = 800
    }
    
    @IBAction func btnSave(_ sender: Any) {
        if (tvBankName.text?.isEmpty)!{
            showAlert(title: "", message: "Please enter bank name.")
        }else if (tvBankAccountNumber.text?.isEmpty)!{
            showAlert(title: "", message: "Please enter accounht number.")
        }else if (tvBankAccountHolderName.text?.isEmpty)!{
            showAlert(title: "", message: "Please enter bank account holder name.")
        }else if (tvIfscCode.text?.isEmpty)!{
            showAlert(title: "", message: "Please enter IFSC Code.")
        }else if (tvBranchName.text?.isEmpty)!{
            showAlert(title: "", message: "Please branch name.")
        }else{
            self.addBank()
        }
        
    }
    
    @IBAction func btnAddBankDetail(_ sender: Any) {
        viewBank.isHidden = false
        constraintBankView.constant = 334
        constraintFullHeight.constant = 1000
    }
    
    @IBAction func btnManageAddress(_ sender: Any) {
     
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
            //    self.showAlert(title: "", message: (result["message"] as? String)!)
                
                
            } else {
               self.showAlert(title: SUCCESS, message: "Bank Detail Added Successfully.")
            }
            
        }
        
    }
    
    
}
