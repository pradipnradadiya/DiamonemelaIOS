
import UIKit
import ObjectMapper

class ShippingVC: UIViewController {

   
    @IBOutlet weak var lblDefaultShipping: UILabel!
    @IBOutlet weak var lblDefaultBilling: UILabel!
    @IBOutlet weak var btnSaveContinue: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let dataArrayString = (UserDefaults.standard.string(forKey: USER_SESSION_DATA_KEY)) {
            
            if let dataObject = Mapper<LoginItem>().map(JSONString: dataArrayString)  {
                lblDefaultBilling.text="\(dataObject.data?.default_billing_new?.firstname ?? "") \(dataObject.data?.default_billing_new?.lastname ?? ""), \n\(dataObject.data?.default_billing_new?.street ?? "") ,\n\(dataObject.data?.default_billing_new?.city ?? ""), \(dataObject.data?.default_billing_new?.postcode ?? ""),\n\(dataObject.data?.default_billing_new?.country_id ?? ""),\n\(dataObject.data?.default_billing_new?.telephone ?? "")"
                
                lblDefaultShipping.text="\(dataObject.data?.default_shipping_new?.firstname ?? "") \(dataObject.data?.default_shipping_new?.lastname ?? ""), \n\(dataObject.data?.default_shipping_new?.street ?? "") ,\n\(dataObject.data?.default_shipping_new?.city ?? ""), \(dataObject.data?.default_shipping_new?.postcode ?? ""),\n\(dataObject.data?.default_shipping_new?.country_id ?? ""),\n\(dataObject.data?.default_shipping_new?.telephone ?? "")"
                
                
            }
        }
        
        
        
        
        // Do any additional setup after loading the view.
    }
   
//    @IBAction func btnSaveContinue(_ sender: Any) {
//        (parent as! SampleProtocol).myPayment()
//    }
    

    @IBAction func btnSaveAndContinue(_ sender: Any) {
         (parent as! SampleProtocol).myPayment()
    }
    @IBAction func btnShippingChange(_ sender: Any) {
        let shipping = self.storyboard?.instantiateViewController(withIdentifier: "SelectAddressVC") as? SelectAddressVC
        shipping?.addressFlag = "Shipping"
        self.navigationController?.pushViewController(shipping!, animated: true)
    }
    @IBAction func btnBillingChange(_ sender: Any) {
        let shipping = self.storyboard?.instantiateViewController(withIdentifier: "SelectAddressVC") as? SelectAddressVC
        shipping?.addressFlag = "Billing"
        self.navigationController?.pushViewController(shipping!, animated: true)
    }
}
