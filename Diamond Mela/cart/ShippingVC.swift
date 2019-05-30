
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
                lblDefaultBilling.text="\(dataObject.data?.default_billing_new?.firstname ?? "") ,\(dataObject.data?.default_billing_new?.lastname ?? ""), \(dataObject.data?.default_billing_new?.street ?? "") ,\(dataObject.data?.default_billing_new?.city ?? ""), \(dataObject.data?.default_billing_new?.postcode ?? "")"
                
                lblDefaultShipping.text="\(dataObject.data?.default_shipping_new?.firstname ?? "") ,\(dataObject.data?.default_shipping_new?.lastname ?? ""), \(dataObject.data?.default_shipping_new?.street ?? "") ,\(dataObject.data?.default_shipping_new?.city ?? ""), \(dataObject.data?.default_shipping_new?.postcode ?? "")"
                
                
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
    }
    @IBAction func btnBillingChange(_ sender: Any) {
    }
}
