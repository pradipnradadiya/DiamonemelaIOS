import UIKit
import ObjectMapper
import RappleProgressHUD

class MyCartVC: UIViewController {
    
    var arrCart = [CartProductListItem.Data]()
    
    @IBOutlet weak var lblGrandTotal: UILabel!
    @IBOutlet weak var lblTax: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    let delegate:SampleProtocol? = nil
    
    @IBOutlet weak var tblCart: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.listCart()
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
                let carts=Mapper<CartProductListItem>().map(JSON: result)
                self.lblSubTotal.text=priceFormat2("\(carts?.subtotal ?? 0)")
                self.lblTax.text=priceFormat2("\(carts?.tax ?? 0)")
                self.lblGrandTotal.text=priceFormat2("\(carts?.grandtotal ?? 0)")
                
                self.arrCart=Mapper<CartProductListItem.Data>().mapArray(JSONArray: result["data"] as! [[String : Any]])
                self.reloadTable()
                
            }
            
        }
        
    }
    
    
    func reloadTable() {
        if self.arrCart.count > 0 {
            //            self.lblNoData.isHidden = true
        } else {
            //            self.lblNoData.isHidden = false
        }
        self.tblCart.reloadData()
    }

    func updateCart() {
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        
        let par = ["customer_id": customerId,"item_id":"","qty":""]
        
        ApiManager.shared.apiUpdateCart(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
//                self.showAlert(title: errorTitle, message: wrongLogin)
                
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


extension MyCartVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tblCart.dequeueReusableCell(withIdentifier: "MyCartCell", for: indexPath) as? MyCartCell
        cell?.myCart = self.arrCart[indexPath.row]
        
        cell?.actionBlockRemove =  {
            
//            self.deleteReferral(referralCustomerId: self.arrReferral[indexPath.row].entity_id!)
//            self.arrReferral.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        cell?.actionBlockPlus = {
            
        }
        
        cell?.actionBlockMinus = {
            
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
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

