import UIKit
import ObjectMapper
import RappleProgressHUD
class SelectShippingVC: UIViewController {

    var shippingData = [PaymentMethodItem.Shipping_charges]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(shippingData[0].method_title as Any)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
extension SelectShippingVC {
    
    func savePayment()  {
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        
        let par = ["customer_id": customerId,
                   "payment_method":"",
                   "shipping_method":"",
                   "shipping_price":""]
        
        ApiManager.shared.apiPaymentSave(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
                
            } else {
                
            }
            
        }
    }
}
