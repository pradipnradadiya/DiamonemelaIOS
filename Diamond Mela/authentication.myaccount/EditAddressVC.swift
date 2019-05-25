import UIKit
import ObjectMapper
import RappleProgressHUD
import JVFloatLabeledTextField

class EditAddressVC: UIViewController {

    @IBOutlet weak var btnDefaultShipping: UIButton!
    @IBOutlet weak var btnDefaultBilling: UIButton!
    @IBOutlet weak var tvCity: JVFloatLabeledTextField!
    @IBOutlet weak var tvState: JVFloatLabeledTextField!
    @IBOutlet weak var tvZipCode: JVFloatLabeledTextField!
    @IBOutlet weak var tvAddress2: JVFloatLabeledTextField!
    @IBOutlet weak var tvAddress1: JVFloatLabeledTextField!
    @IBOutlet weak var tvTel: JVFloatLabeledTextField!
    @IBOutlet weak var tvLnm: JVFloatLabeledTextField!
    @IBOutlet weak var tvFnm: JVFloatLabeledTextField!
    
    var countryData:[CountryResponse.Data] = []
    var stateData:[StateResponse.Data] = []
    
    var countryId : String = ""
    var stateId : String = ""
    var billingFlag : String = "0"
    var shippingFlag :String = "0"
    
    var status:String? = ""
    var defaultBilling:AddressManageResponse.Default_billing?
    var defaultShipping:AddressManageResponse.Default_shipping?
    var additionData:AddressManageResponse.Data?
    
    var btnTag : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.navigationController?.title="Add Address"
        btnDefaultBilling.isSelected=true
        btnDefaultShipping.isSelected=true
        self.postInitView()
        self.getCountry(url: Endpoint.getCountryList.url)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSetAsDefaultShipping(_ sender: UIButton) {
        if sender.isSelected {
            sender.setImage(UIImage(named: "checked"), for: .normal)
            shippingFlag = "1";
            sender.isSelected=false
        }else{
            sender.setImage(UIImage(named: "unchecked"), for: .normal)
            shippingFlag = "0";
            sender.isSelected=true
        }
    }
    @IBAction func btnSetAsDefaultBilling(_ sender: UIButton) {
        if sender.isSelected {
            sender.setImage(UIImage(named: "checked"), for: .normal)
            billingFlag = "1";
            sender.isSelected=false
        }else{
            sender.setImage(UIImage(named: "unchecked"), for: .normal)
            billingFlag = "0";
            sender.isSelected=true
        }
        
        
    }
    @IBAction func btnCart(_ sender: Any) {
    }
    @IBAction func btnSearch(_ sender: Any) {
    }
    @IBAction func btnSelectCountry(_ sender: Any) {
    }
    @IBAction func btnSave(_ sender: Any) {
        
        if status=="1"{
            if countryId==INDIA_CODE {
                self.editBillingAddress(addressId: (self.defaultBilling?.entity_id!)!, fnm: tvFnm.text!, lnm: tvLnm.text!, street: tvAddress1.text!, street2: tvAddress2.text!, city: tvCity.text!, regionId: stateId, region: "", postCode: tvZipCode.text!, countryId: countryId, telephone: tvTel.text!)
            }else{
                if tvState.text==""{
                    self.showAlert(title: "", message: ENTER_STATE)
                }else{
                    self.editBillingAddress(addressId: (self.defaultBilling?.entity_id!)!, fnm: tvFnm.text!, lnm: tvLnm.text!, street: tvAddress1.text!, street2: tvAddress2.text!, city: tvCity.text!, regionId: stateId, region: "", postCode: tvZipCode.text!, countryId: countryId, telephone: tvTel.text!)
                }
            }
        }else if status=="2"{
            if countryId==INDIA_CODE {
                
                 self.editShippingAddress(addressId: (self.defaultShipping?.entity_id!)!, fnm: tvFnm.text!, lnm: tvLnm.text!, street: tvAddress1.text!, street2: tvAddress2.text!, city: tvCity.text!, regionId: stateId, region: "", postCode: tvZipCode.text!, countryId: countryId, telephone: tvTel.text!)
                
                
            }else{
                if tvState.text==""{
                    self.showAlert(title: "", message: ENTER_STATE)
                }else{
                    self.editShippingAddress(addressId: (self.defaultShipping?.entity_id!)!, fnm: tvFnm.text!, lnm: tvLnm.text!, street: tvAddress1.text!, street2: tvAddress2.text!, city: tvCity.text!, regionId: stateId, region: "", postCode: tvZipCode.text!, countryId: countryId, telephone: tvTel.text!)
                }
            }
            
        }else if status=="3"{
            if countryId==INDIA_CODE {
                self.editAdditionalAddress(addressId: (self.additionData?.entity_id!)!, address_billing_flag: billingFlag, address_shiping_flag: shippingFlag, fnm: tvFnm.text!, lnm: tvLnm.text!, street: tvAddress1.text!, street2: tvAddress2.text!, city: tvCity.text!, regionId: stateId, region: "", postCode: tvZipCode.text!, countryId: countryId, telephone: tvTel.text!)
            }else{
                if tvState.text==""{
                    self.showAlert(title: "", message: ENTER_STATE)
                }else{
                    self.editAdditionalAddress(addressId: (self.additionData?.entity_id!)!, address_billing_flag: billingFlag, address_shiping_flag: shippingFlag, fnm: tvFnm.text!, lnm: tvLnm.text!, street: tvAddress1.text!, street2: tvAddress2.text!, city: tvCity.text!, regionId: stateId, region: "", postCode: tvZipCode.text!, countryId: countryId, telephone: tvTel.text!)
                }
            }
        }else if status=="4"{
            if countryId==INDIA_CODE {
                self.addAddress(address_billing_flag: billingFlag, address_shipping_flag: shippingFlag, fnm: tvFnm.text!, lnm: tvLnm.text!, street: tvAddress1.text!, street2: tvAddress2.text!, city: tvCity.text!, regionId: stateId, region: "", postCode: tvZipCode.text!, countryId: countryId, telephone: tvTel.text!)
            }else{
                if self.tvState.text == ""{
                    self.showAlert(title: "", message: ENTER_STATE)
                }else{
                     self.addAddress(address_billing_flag: billingFlag, address_shipping_flag: shippingFlag, fnm: tvFnm.text!, lnm: tvLnm.text!, street: tvAddress1.text!, street2: tvAddress2.text!, city: tvCity.text!, regionId: stateId, region: "", postCode: tvZipCode.text!, countryId: countryId, telephone: tvTel.text!)
                }
            }
        }else if status=="5"{
            if countryId==INDIA_CODE {
                self.addAddress(address_billing_flag: billingFlag, address_shipping_flag: shippingFlag, fnm: tvFnm.text!, lnm: tvLnm.text!, street: tvAddress1.text!, street2: tvAddress2.text!, city: tvCity.text!, regionId: stateId, region: "", postCode: tvZipCode.text!, countryId: countryId, telephone: tvTel.text!)
            }else{
                if self.tvState.text == ""{
                    self.showAlert(title: "", message: ENTER_STATE)
                }else{
                    self.addAddress(address_billing_flag: billingFlag, address_shipping_flag: shippingFlag, fnm: tvFnm.text!, lnm: tvLnm.text!, street: tvAddress1.text!, street2: tvAddress2.text!, city: tvCity.text!, regionId: stateId, region: "", postCode: tvZipCode.text!, countryId: countryId, telephone: tvTel.text!)
                }
            }
        }
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func postInitView() {
        
        if status=="1"{
            
            self.btnDefaultBilling.isHidden=true
            self.btnDefaultShipping.isHidden=true
            
            self.tvFnm.text=defaultBilling?.firstname
            self.tvLnm.text=defaultBilling?.lastname
            self.tvTel.text=defaultBilling?.telephone
            self.tvAddress1.text=defaultBilling?.street
            self.tvAddress2.text=defaultBilling?.street
            self.tvZipCode.text=defaultBilling?.postcode
            self.tvCity.text=defaultBilling?.city
        }else if status=="2"{
            self.tvFnm.text=defaultShipping?.firstname
            self.tvLnm.text=defaultShipping?.lastname
            self.tvTel.text=defaultShipping?.telephone
            self.tvAddress1.text=defaultShipping?.street
            self.tvAddress2.text=defaultShipping?.street
            self.tvZipCode.text=defaultShipping?.postcode
            self.tvCity.text=defaultShipping?.city
            
            self.btnDefaultBilling.isHidden=true
            self.btnDefaultShipping.isHidden=true
            
        }else if status=="3"{
            self.tvFnm.text=additionData?.firstname
            self.tvLnm.text=additionData?.lastname
            self.tvTel.text=additionData?.telephone
            self.tvAddress1.text=additionData?.street
            self.tvAddress2.text=additionData?.street
            self.tvZipCode.text=additionData?.postcode
            self.tvCity.text=additionData?.city
        }else if status=="4"{
            
        }else if status=="5"{
            self.btnDefaultBilling.isHidden=true
            self.btnDefaultShipping.isHidden=true
        }
        
        
    }
    
}
extension EditAddressVC{
    
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
                print(self.countryData[0].name as Any)
                
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
                
                let stateList=Mapper<StateResponse>().map(JSON: result)
                self.stateData=(stateList?.data)!
                print(stateList as Any)
                
            }
            
        }
        
    }
    
    func addAddress(address_billing_flag:String,address_shipping_flag:String,fnm:String,lnm:String,street:String,street2:String,city:String,regionId:String,region:String,postCode:String,countryId:String,telephone:String){
        
        let par = ["customer_id": customerId,
                   "address_billing_flag":address_billing_flag,
                   "address_shipping_flag":address_shipping_flag,
                   "firstname":fnm,
                   "lastname":lnm,
                   "street":street,
                   "street1":street2,
                   "city":city,
                   "region_id":regionId,
                   "region":region,
                   "postcode":postCode,
                   "country_id":countryId,
                   "telephone":telephone]
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiAddNewAddress(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                
            }
            
        }
    }
    
    func editBillingAddress(addressId:String,fnm:String,lnm:String,street:String,street2:String,city:String,regionId:String,region:String,postCode:String,countryId:String,telephone:String) {
        let par = ["customer_id": customerId,
                   "address_id":addressId,
                   "firstname":fnm,
                   "lastname":lnm,
                   "street":street,
                   "street1":street2,
                   "city":city,
                   "region_id":regionId,
                   "region":region,
                   "postcode":postCode,
                   "country_id":countryId,
                   "telephone":telephone]
        
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiEditDefaultBilling(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
                
            } else {
                
            }
            
        }
        
    }
    
    func editShippingAddress(addressId:String,fnm:String,lnm:String,street:String,street2:String,city:String,regionId:String,region:String,postCode:String,countryId:String,telephone:String) {
        let par = ["customer_id": customerId,
                   "address_id":addressId,
                   "firstname":fnm,
                   "lastname":lnm,
                   "street":street,
                   "street1":street2,
                   "city":city,
                   "region_id":regionId,
                   "region":region,
                   "postcode":postCode,
                   "country_id":countryId,
                   "telephone":telephone]
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiEditDefaultShipping(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
                
            } else {
                
            }
            
        }
        
    }
    
    func editAdditionalAddress(addressId:String,address_billing_flag:String,address_shiping_flag:String,fnm:String,lnm:String,street:String,street2:String,city:String,regionId:String,region:String,postCode:String,countryId:String,telephone:String) {
        let par = ["customer_id": customerId,
                   "address_id":addressId,
                   "address_billing_flag":address_billing_flag,
                   "address_shipping_flag":address_shiping_flag,
                   "firstname":fnm,
                   "lastname":lnm,
                   "street":street,
                   "street1":street2,
                   "city":city,
                   "region_id":regionId,
                   "region":region,
                   "postcode":postCode,
                   "country_id":countryId,
                   "telephone":telephone]
        
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiEditDefaultShipping(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
                
            } else {
                
            }
            
        }
        
    }
    
}
