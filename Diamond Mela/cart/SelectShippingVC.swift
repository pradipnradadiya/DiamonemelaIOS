import UIKit
import ObjectMapper
import RappleProgressHUD
class SelectShippingVC: UIViewController {

    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var tblShipping: UITableView!
    var shippingData = [PaymentMethodItem.Shipping_charges]()
    var paymentTypes:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadTable()
        self.btnContinue.isEnabled = false
        print(shippingData[0].method_title as Any)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnContinue(_ sender: Any) {
        let orderSummary = self.storyboard?.instantiateViewController(withIdentifier: "OrderSummaryVC") as? OrderSummaryVC
        self.navigationController?.pushViewController(orderSummary!, animated: true)
    }
    
}

extension SelectShippingVC {
    
    
    func reloadTable(){
        if self.shippingData.count > 0 {
            //            self.lblNoData.isHidden = true
        } else {
            //            self.lblNoData.isHidden = false
        }
        self.tblShipping.reloadData()
    }
    
    func savePayment(shippingMethod:String,shippingPrice:String)  {
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        
        let par = ["customer_id": customerId,
                   "payment_method":paymentTypes,
                   "shipping_method":shippingMethod,
                   "shipping_price":shippingPrice]
        
        ApiManager.shared.apiPaymentSave(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                                
            } else {
                self.btnContinue.isEnabled = true
            }
            
        }
    }
}


extension SelectShippingVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shippingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = self.tblShipping.dequeueReusableCell(withIdentifier: "ShippingCell", for: indexPath) as? ShippingCell
            cell?.shippingData = self.shippingData[indexPath.row]
       
            return cell!
            
        }else{
            let cell = self.tblShipping.dequeueReusableCell(withIdentifier: "ShippingCell2", for: indexPath) as? ShippingCell2
            cell?.shippingData = self.shippingData[indexPath.row]
            
            return cell!
        }
     
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        if indexPath.row == 0{
            
            savePayment(shippingMethod: self.shippingData[indexPath.row].code!, shippingPrice: "\(self.shippingData[indexPath.row].price ?? 0)")
            
            
            var i :Int = 0
            for _ in self.shippingData{
               print(i)
                
                if i != indexPath.row{
                    self.shippingData[i].isSelected = false
                }else{
                    self.shippingData[i].isSelected = true
                }
                
                i += 1
            }
            
            self.tblShipping.reloadData()
            
            
            
            
            
            
        }else{
            
             savePayment(shippingMethod: self.shippingData[indexPath.row].code!, shippingPrice: "\(self.shippingData[indexPath.row].price ?? 0)")
            
            var i :Int = 0
            for _ in self.shippingData{
                print(i)
                
                if i != indexPath.row{
                    self.shippingData[i].isSelected = false
                }else{
                    self.shippingData[i].isSelected = true
                }
                
                i += 1
            }
            
            self.tblShipping.reloadData()
            
           
        }
        
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
