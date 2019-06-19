import UIKit
import ObjectMapper
import RappleProgressHUD

class PaymentVC: UIViewController {

    @IBOutlet weak var tblPaymentMethodSelect: UITableView!
    @IBOutlet weak var btnContinue: UIButton!
    
    var arrPaymentMethod = [PaymentMethodItem.Data]()
    
    var shippingData = [PaymentMethodItem.Shipping_charges]()
    
    var paymentTypes:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getSelectPayment()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnContinue(_ sender: Any) {
        let shipping = self.storyboard?.instantiateViewController(withIdentifier: "SelectShippingVC") as? SelectShippingVC
        shipping?.shippingData=self.shippingData
        shipping?.paymentTypes=self.paymentTypes
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
                
                 self.arrPaymentMethod=Mapper<PaymentMethodItem.Data>().mapArray(JSONArray: result["data"] as! [[String : Any]])
                self.arrPaymentMethod[0].isSelected = true
                self.paymentTypes=self.arrPaymentMethod[0].value!
                self.reloadTable()
                
            }
            
        }
    }
    func reloadTable() {
        if self.arrPaymentMethod.count > 0 {
            //            self.lblNoData.isHidden = true
        } else {
            //            self.lblNoData.isHidden = false
        }
        self.tblPaymentMethodSelect.reloadData()
    }
   
    
    
}


extension PaymentVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrPaymentMethod.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = self.tblPaymentMethodSelect.dequeueReusableCell(withIdentifier: "PaymentCell", for: indexPath) as? PaymentCell
            cell?.payment = self.arrPaymentMethod[indexPath.row]
            
            cell?.actionClickPayment = {
                self.paymentTypes=self.arrPaymentMethod[indexPath.row].value!
                self.arrPaymentMethod[0].isSelected = true
                self.arrPaymentMethod[1].isSelected = false
                self.reloadTable()
                
            }
            
            return cell!
            
        }else{
            let cell = self.tblPaymentMethodSelect.dequeueReusableCell(withIdentifier: "PaymentCell2", for: indexPath) as? PaymentCell2
            cell?.payment = self.arrPaymentMethod[indexPath.row]
            
            cell?.actionClick = {
                self.paymentTypes=self.arrPaymentMethod[indexPath.row].value!
                
                self.arrPaymentMethod[0].isSelected = false
                self.arrPaymentMethod[1].isSelected = true
                
                self.reloadTable()
                
            }
            
            return cell!
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        self.paymentTypes=self.arrPaymentMethod[indexPath.row].value!
        print(paymentTypes)
        
        
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

