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
    
    @IBOutlet weak var constraintTableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var constraintMainHeight: NSLayoutConstraint!
    var arrOrderProduct = [OrderSummaryItem.Data]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let dataArrayString = (UserDefaults.standard.string(forKey: BILLING_USERDEFAULTS)) {
            
            lblBillingAddress.text = dataArrayString.uppercased()
            
            
            
        }
        
        if let dataArrayString = (UserDefaults.standard.string(forKey: SHIPPING_USERDEFAULTS)) {
            lblShippingAddress.text = dataArrayString.uppercased()
            
        }
        
        
        self.orderSummary()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
            
            let totalHeight:Int = self.arrOrderProduct.count * 180
            
            constraintTableHeight.constant = CGFloat(50 + totalHeight)
            
            
            self.constraintMainHeight.constant = CGFloat(530 + totalHeight)
            
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

