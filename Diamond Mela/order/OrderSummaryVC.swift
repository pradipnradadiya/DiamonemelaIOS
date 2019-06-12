import UIKit
import ObjectMapper
import RappleProgressHUD

class OrderSummaryVC: UIViewController {
    @IBOutlet weak var lblTax: UILabel!
    @IBOutlet weak var tblOrderSummary: UITableView!
    @IBOutlet weak var lblGrandTotal: UILabel!
    @IBOutlet weak var lblShippingCharge: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblShippingAddress: UILabel!
    @IBOutlet weak var lblBillingAddress: UILabel!
    @IBOutlet weak var lblPaymentMethod: UILabel!
    
    
    var arrOrderProduct = [OrderSummaryItem.Data]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.orderSummary()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnPlaceOrder(_ sender: Any) {
        
        self.placeOrder()
        
    }
    
}
extension OrderSummaryVC{
    
    func orderSummary(){
        
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        
        let par = ["customer_id": customerId]
        
        ApiManager.shared.apiOrderSummary(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
                
            } else {
                let orderSummary=Mapper<OrderSummaryItem>().map(JSON: result)
                
                self.lblPaymentMethod.text=orderSummary?.payment
                
                if let dataArrayString = (UserDefaults.standard.string(forKey: USER_SESSION_DATA_KEY)) {
                    
                    if let dataObject = Mapper<LoginItem>().map(JSONString: dataArrayString)  {
                        self.lblBillingAddress.text="\(dataObject.data?.default_billing_new?.firstname ?? "") ,\(dataObject.data?.default_billing_new?.lastname ?? ""), \(dataObject.data?.default_billing_new?.street ?? "") ,\(dataObject.data?.default_billing_new?.city ?? ""), \(dataObject.data?.default_billing_new?.postcode ?? "")"
                        
                        self.lblShippingAddress.text="\(dataObject.data?.default_shipping_new?.firstname ?? "") ,\(dataObject.data?.default_shipping_new?.lastname ?? ""), \(dataObject.data?.default_shipping_new?.street ?? "") ,\(dataObject.data?.default_shipping_new?.city ?? ""), \(dataObject.data?.default_shipping_new?.postcode ?? "")"
                        
                        
                    }
                }
                
                self.lblSubTotal.text=priceFormat2("\(orderSummary?.subtotal ?? 0)")
                self.lblShippingCharge.text=priceFormat2("\(orderSummary?.shipping_charges ?? 0)")
                self.lblTax.text=priceFormat2("\(orderSummary?.tax_ammount ?? 0)")
                self.lblGrandTotal.text=priceFormat2("\(orderSummary?.grand_total ?? 0)")
                
                
                
                self.arrOrderProduct=Mapper<OrderSummaryItem.Data>().mapArray(JSONArray: result["data"] as! [[String : Any]])
                self.reloadTable()
                
            }
            
        }
    }
    func reloadTable(){
        if self.arrOrderProduct.count > 0 {
            //            self.lblNoData.isHidden = true
        } else {
            //            self.lblNoData.isHidden = false
        }
        self.tblOrderSummary.reloadData()
    }
    
    
    func placeOrder(){
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        
        let par = ["customer_id": customerId]
        
        ApiManager.shared.apiPlaceOrder(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
                
            } else {
                let alert = UIAlertController(title: SUCCESS, message: result["message"] as? String, preferredStyle: .alert)
                
                let ok = UIAlertAction(title: OK, style: .default, handler: { action in
                    
                    let signup = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
                    self.navigationController?.pushViewController(signup!, animated: true)
                    
                    
                })
                alert.addAction(ok)
                
                DispatchQueue.main.async(execute: {
                    self.present(alert, animated: true)
                })
                
            }
            
        }
    }
}


extension OrderSummaryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrOrderProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tblOrderSummary.dequeueReusableCell(withIdentifier: "OrderSummaryCell", for: indexPath) as? OrderSummaryCell
        cell?.orderData = self.arrOrderProduct[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

