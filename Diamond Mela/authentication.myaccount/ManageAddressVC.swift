import UIKit
import ObjectMapper
import RappleProgressHUD

class ManageAddressVC: UIViewController {
    
    var addressData : AddressManageResponse?
    var arrManageAddress = [AddressManageResponse.Data]()
    
    
    
    @IBOutlet weak var tblAdditionalAddress: UITableView!
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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAllAddress()
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAddNewAddress(_ sender: Any) {
        let address = self.storyboard?.instantiateViewController(withIdentifier: "EditAddressVC") as? EditAddressVC
        address?.status="4"
        self.navigationController?.pushViewController(address!, animated: true)
    }
    @IBAction func btnDefaultShippingChangeAddress(_ sender: Any) {
        let address = self.storyboard?.instantiateViewController(withIdentifier: "EditAddressVC") as? EditAddressVC
        address?.status="2"
        address?.defaultShipping = addressData?.default_shipping
        self.navigationController?.pushViewController(address!, animated: true)
    }
    @IBAction func btnDefaultBillingChangeAddress(_ sender: Any) {
        let address = self.storyboard?.instantiateViewController(withIdentifier: "EditAddressVC") as? EditAddressVC
        address?.status="1"
        address?.defaultBilling = addressData?.default_billing
        self.navigationController?.pushViewController(address!, animated: true)
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSearch(_ sender: Any) {
    }
    
    @IBAction func btnCart(_ sender: Any) {
    }
}


extension ManageAddressVC {
    
    func getAllAddress(showLoader: Bool = false) {
        
        
        if showLoader {
            RESpinner.shared.show(view: self.view)
        }
        
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        
        let par = ["customer_id": customerId]
        
        ApiManager.shared.apiGetAllAddress(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            RESpinner.shared.hide()
            
            let status = result[STATUS_CODE] as? String
            
            if status == FAILURE_CODE || status == nil {
                self.showAlert(title: errorTitle, message: wrongLogin)
            } else {
                //                 let loginData = Mapper<LoginItem.Data>().mapArray(JSONArray: result["data"] as! [[String : Any]])
                self.addressData = Mapper<AddressManageResponse>().map(JSON: result)
                print(self.addressData?.default_billing?.country as Any)
                print(self.addressData?.default_shipping?.country as Any)
                
                
                self.lblDefaultShippingTel.text=self.addressData?.default_shipping?.telephone
                self.lblDefaultShippingCountry.text=self.addressData?.default_shipping?.country
                self.lblDefaultShippingCityState.text="\(self.addressData?.default_shipping?.city ?? "") \(self.addressData?.default_shipping?.region ?? "") \(self.addressData?.default_shipping?.postcode ?? "")"
                self.lblDefaultShippingAddress.text=self.addressData?.default_shipping?.street
                self.lblDefaultShippingName.text="\(self.addressData?.default_shipping?.firstname ?? "") \(self.addressData?.default_shipping?.lastname ?? "")"
                
                self.lblDefaultBillingTel.text=self.addressData?.default_billing?.telephone
                self.lblDefaultBillingCountry.text=self.addressData?.default_billing?.country
                self.lblDefaultBillingCityState.text="\(self.addressData?.default_billing?.city ?? "") \(self.addressData?.default_billing?.region ?? "") \(self.addressData?.default_billing?.postcode ?? "")"
                self.lblDefaultBillingAddress.text=self.addressData?.default_billing?.street
                self.lblDefaultBillingName.text="\(self.addressData?.default_billing?.firstname ?? "") \(self.addressData?.default_billing?.lastname ?? "")"
                
                
                let addtionalData=Mapper<AddressManageResponse.Data>().mapArray(JSONArray: result["data"] as! [[String : Any]])
                print(addtionalData[0].country_id as Any)
                print("success")
                self.tblAdditionalAddress.reloadData()
                self.arrManageAddress = addtionalData
                self.reloadTable()
                
            }
            
        }
        
    }
    
    func deleteAddress(addressId:String,customerId:String) {
        let par = ["address_id": addressId,"customer_id":customerId]
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiDeleteAddress(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                
            }
            
        }
    }
    
   
    func reloadTable() {
        if self.arrManageAddress.count > 0 {
            //            self.lblNoData.isHidden = true
        } else {
            //            self.lblNoData.isHidden = false
        }
        self.tblAdditionalAddress.reloadData()
    }
    
    
    
}


extension ManageAddressVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrManageAddress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = self.tblAdditionalAddress.dequeueReusableCell(withIdentifier: "ManageAddressCell", for: indexPath) as? ManageAddressCell
        cell?.addressData = self.arrManageAddress[indexPath.row]
        
        cell?.actionBlockDelete = {
            
            self.deleteAddress(addressId: self.arrManageAddress[indexPath.row].entity_id!, customerId: customerId)
            self.arrManageAddress.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        cell?.actionBlockEdit = {
            let editAddress = self.storyboard?.instantiateViewController(withIdentifier: "EditAddressVC") as? EditAddressVC
            editAddress?.status = "3"
            editAddress?.additionData = self.arrManageAddress[indexPath.row]
            self.navigationController?.pushViewController(editAddress!, animated: true)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        self.arrQA[indexPath.row].is_viewed=true
        //        self.tblQA.reloadRows(at: [indexPath], with: .automatic)
        
        //        let qadetail = self.storyboard?.instantiateViewController(withIdentifier: "QADetailVC") as? QADetailVC
        //        qadetail?.qa = self.arrQA[indexPath.row]
        //        qadetail?.qid = self.arrQA[indexPath.row].iD!
        //        self.navigationController?.pushViewController(qadetail!, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

