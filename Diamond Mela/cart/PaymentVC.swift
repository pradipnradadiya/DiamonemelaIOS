import UIKit
import ObjectMapper
import RappleProgressHUD

class PaymentVC: UIViewController {

    @IBOutlet weak var btnContinue: UIButton!
    
    var shippingData = [PaymentMethodItem.Shipping_charges]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getSelectPayment()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnContinue(_ sender: Any) {
        let shipping = self.storyboard?.instantiateViewController(withIdentifier: "SelectShippingVC") as? SelectShippingVC
        shipping?.shippingData=self.shippingData
        self.navigationController?.pushViewController(shipping!, animated: true)
    }
    

}

extension PaymentVC{
    func getSelectPayment()  {
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        
        let par = ["customer_id": customerId]
        
        ApiManager.shared.apiSelectPaymentMethod(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
                
            } else {
                self.shippingData=Mapper<PaymentMethodItem.Shipping_charges>().mapArray(JSONArray: result["shipping_charges"] as! [[String : Any]])
                
                let methodData=Mapper<PaymentMethodItem.Data>().mapArray(JSONArray: result["data"] as! [[String : Any]])
                
                
            }
            
        }
    }
    
   
    
    
}
