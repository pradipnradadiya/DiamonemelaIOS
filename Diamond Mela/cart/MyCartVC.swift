import UIKit
import ObjectMapper
import RappleProgressHUD

class MyCartVC: UIViewController {
    
    let delegate:SampleProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnContinueProceed(_ sender: Any) {
         (parent as? SampleProtocol)?.myShipping()
    }
    

}

extension MyCartVC{
    
    func listCart() {
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        
        let par = ["customer_id": customerId]
        
        ApiManager.shared.apiCartList(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                self.showAlert(title: errorTitle, message: wrongLogin)
                
            } else {
               
            }
            
        }
    }
    
    func updateCart() {
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        
        let par = ["customer_id": customerId,"item_id":"","qty":""]
        
        ApiManager.shared.apiUpdateCart(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                self.showAlert(title: errorTitle, message: wrongLogin)
                
            } else {
                
            }
            
        }
    }
    
    func delteCartItem() {
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        
        let par = ["customer_id": customerId,"item_id":""]
        
        ApiManager.shared.apiDeleteCart(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                self.showAlert(title: errorTitle, message: wrongLogin)
                
            } else {
                
            }
            
        }
    }
    
    
    
}
