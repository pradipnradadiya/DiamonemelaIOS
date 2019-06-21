import UIKit
import ObjectMapper
import RappleProgressHUD

class SelectAddressVC: UIViewController {

    var addressFlag:String = ""
     var arrManageAddress = [AddressManageResponse.Data]()
    
    @IBOutlet weak var tblSelectAddress: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getAllAddress(showLoader: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnAddNewAddress(_ sender: Any) {
        let address = self.storyboard?.instantiateViewController(withIdentifier: "EditAddressVC") as? EditAddressVC
        address?.status="5"
        self.navigationController?.pushViewController(address!, animated: true)
    }
    
}

extension SelectAddressVC {
    
    func getAllAddress(showLoader: Bool = false) {
        
        
        if showLoader {
            RESpinner.shared.show(view: self.view)
        }
        
//        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        
        let par = ["customer_id": customerId]
        
        ApiManager.shared.apiGetAllAddress(params:par as [String : AnyObject]) { (result) in
            
//            RappleActivityIndicatorView.stopAnimation()
            RESpinner.shared.hide()
            
            let status = result[STATUS_CODE] as? String
            
            if status == FAILURE_CODE || status == nil {
                self.showAlert(title: errorTitle, message: wrongLogin)
            } else {
               
                self.arrManageAddress=Mapper<AddressManageResponse.Data>().mapArray(JSONArray: result["data"] as! [[String : Any]])
//                print(addtionalData[0].country_id as Any)
//                print("success")
                self.tblSelectAddress.reloadData()
//                self.arrManageAddress = addtionalData
                self.reloadTable()
                
            }
            
        }
        
    }
  
    
    func setAddress(address_id:String,flag_shipping:String){
        
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        
        let par = ["customer_id": customerId,
                   "address_id":address_id,
                   "flag_shipping":flag_shipping]
        
        ApiManager.shared.apiSetAddress(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
           
            
            let status = result[STATUS_CODE] as? String
            
            if status == FAILURE_CODE || status == nil {
                self.showAlert(title: errorTitle, message: wrongLogin)
            } else {
                
                self.navigationController?.popViewController(animated: true)
                
            }
        }
            
    }
    
    
    func reloadTable() {
        if self.arrManageAddress.count > 0 {
            //            self.lblNoData.isHidden = true
        } else {
            //            self.lblNoData.isHidden = false
        }
        self.tblSelectAddress.reloadData()
    }
   
}


extension SelectAddressVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrManageAddress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tblSelectAddress.dequeueReusableCell(withIdentifier: "SelectAddressCell", for: indexPath) as? SelectAddressCell
        cell?.addressData = self.arrManageAddress[indexPath.row]
        
        cell?.actionBlockSelect = {
            
            
            if self.addressFlag == "Billing"{
                
                
                 userSessionData.set("\(self.arrManageAddress[indexPath.row].firstname ?? "")  \(self.arrManageAddress[indexPath.row].lastname ?? ""),\n\(self.arrManageAddress[indexPath.row].street ?? ""),\n\(self.arrManageAddress[indexPath.row].city ?? ""), \(self.arrManageAddress[indexPath.row].region ?? ""), \(self.arrManageAddress[indexPath.row].postcode ?? ""),\n\(self.arrManageAddress[indexPath.row].country_id ?? ""),\nT: \(self.arrManageAddress[indexPath.row].telephone ?? "")", forKey: BILLING_USERDEFAULTS)
                
                
                self.setAddress(address_id: self.arrManageAddress[indexPath.row].entity_id!, flag_shipping: self.addressFlag)
            }else if self.addressFlag == "Shipping"{
                 userSessionData.set("\(self.arrManageAddress[indexPath.row].firstname ?? "")  \(self.arrManageAddress[indexPath.row].lastname ?? ""),\n\(self.arrManageAddress[indexPath.row].street ?? ""),\n\(self.arrManageAddress[indexPath.row].city ?? ""), \(self.arrManageAddress[indexPath.row].region ?? ""), \(self.arrManageAddress[indexPath.row].postcode ?? ""),\n\(self.arrManageAddress[indexPath.row].country_id ?? ""),\nT: \(self.arrManageAddress[indexPath.row].telephone ?? "")", forKey: SHIPPING_USERDEFAULTS)
                self.setAddress(address_id: self.arrManageAddress[indexPath.row].entity_id!, flag_shipping: self.addressFlag)
            }
            
            
            
            
            
            
//            self.deleteAddress(addressId: self.arrManageAddress[indexPath.row].entity_id!, customerId: customerId)
//            self.arrManageAddress.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

