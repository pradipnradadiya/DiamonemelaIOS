import UIKit
import ObjectMapper
import RappleProgressHUD

class MyCartVC: UIViewController {
    
    var arrCart = [CartProductListItem.Data]()
    
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var lblGrandTotal: UILabel!
    @IBOutlet weak var lblTax: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    var subTotal = Float()
    var tax = Float()
    var grandTotal = Float()
    
    let delegate:SampleProtocol? = nil
    
    @IBOutlet weak var tblCart: UITableView!
    
    var flag:Int = 0
    //cart array dictionry
    var arrayOfDict = [[String: String]]()
    var dictCart =  [String: String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if (UserDefaults.standard.string(forKey: USER_SESSION_DATA_KEY)) != nil {
            flag = 0
            self.listCart()
        }else{
            self.btnContinue.isEnabled = false
            flag = 1
            manageCart()
//            if let dataArrayString = (UserDefaults.standard.string(forKey: CART_USERDEFAULTS)) {
            
            
            
            
            
//            }else{
//                self.showAlert(title: errorTitle, message: "Cart is Empty")
//                self.btnContinue.isEnabled = false
//            }
            
            print(arrayOfDict)
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func manageCart()  {
        
        if (UserDefaults.standard.array(forKey: CART_USERDEFAULTS)) != nil {
            subTotal = 0
            tax = 0
            grandTotal = 0
            arrayOfDict = userSessionData.value(forKey: CART_USERDEFAULTS) as! [[String : String]]
            
            if arrayOfDict.isEmpty{
                self.showAlert(title: FAILURE_CODE, message: "Cart is empty.")
                btnContinue.isEnabled = false
            }else{
                btnContinue.isEnabled = true
                
            var i:Int = 0
            for _ in arrayOfDict{
                let price:Float = Float("\(arrayOfDict[i][PRICE] ?? "0")")! * Float("\(arrayOfDict[i][QTY] ?? "0")")!
                subTotal = subTotal + price
                i += 1
            }
            
            tax = (subTotal * 3) / 100
            grandTotal = subTotal + tax
            
            self.lblSubTotal.text=priceFormat2("\(subTotal)")
            self.lblTax.text=priceFormat2("\(tax)")
            self.lblGrandTotal.text=priceFormat2("\(grandTotal)")
            
            tblCart.reloadData()
            }
            
            
            
        }
        else{
            self.showAlert(title: FAILURE_CODE, message: "Cart is empty.")
        }
        
        
        
        
        
    }
    
    
    @IBAction func btnContinueProceed(_ sender: Any) {
        if (UserDefaults.standard.string(forKey: USER_SESSION_DATA_KEY)) != nil {
            
            if arrCart.isEmpty{
                self.showAlert(title: FAILURE_CODE, message: "Cart is empty.")
            }else{
                (parent as? SampleProtocol)?.myShipping()
            }
           
            
            
        }else{
            self.registerPopop()
        }
        
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
            if status == "fail" || status == nil {
                self.showAlert(title: errorTitle, message: "Cart is Empty")
                self.btnContinue.isEnabled = false
                
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

    
    
    func updateCartTotal() {
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        
        let par = ["customer_id": customerId]
        ApiManager.shared.apiCartList(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == "fail" || status == nil {
                self.showAlert(title: errorTitle, message: "Cart is Empty")
                self.btnContinue.isEnabled = false
                
            } else {
                let carts=Mapper<CartProductListItem>().map(JSON: result)
                self.lblSubTotal.text=priceFormat2("\(carts?.subtotal ?? 0)")
                self.lblTax.text=priceFormat2("\(carts?.tax ?? 0)")
                self.lblGrandTotal.text=priceFormat2("\(carts?.grandtotal ?? 0)")
             
            }
            
        }
        
    }
    
    func updateCart(itemId:String,qty:String) {
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        print(qty)
        let par = ["customer_id": customerId,"item_id":itemId,"qty":qty]
        
        ApiManager.shared.apiUpdateCart(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
//                self.showAlert(title: errorTitle, message: wrongLogin)
                
            } else {
                self.updateCartTotal()
            }
            
        }
        
    }
    
    func delteCartItem(itemId:String) {
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        
        let par = ["customer_id": customerId,"item_id":itemId]
        
        ApiManager.shared.apiDeleteCart(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
                
            } else {
                 self.updateCartTotal()
            }
            
        }
        
    }
  
}


extension MyCartVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flag == 0{
            return self.arrCart.count
        }else{
            return arrayOfDict.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if flag == 0{
        
        let cell = self.tblCart.dequeueReusableCell(withIdentifier: "MyCartCell", for: indexPath) as? MyCartCell
        cell?.myCart = self.arrCart[indexPath.row]
        
        cell?.actionBlockRemove =  {
            
            let refreshAlert = UIAlertController(title: DELETE, message: ARE_U_SURE_DEL, preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: OK, style: .default, handler: { (action: UIAlertAction!) in
                
                self.delteCartItem(itemId: self.arrCart[indexPath.row].itemid ?? "")
                self.arrCart.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
              
            }))
            
            refreshAlert.addAction(UIAlertAction(title: CANCEL, style: .cancel, handler: { (action: UIAlertAction!) in
                
            }))
            
            self.present(refreshAlert, animated: true, completion: nil)
         
           
        }
        
        cell?.actionBlockPlus = {
            var qty:Int = self.arrCart[indexPath.row].qty ?? 0
                qty += 1
            cell?.lblQty.text = String(qty)
            self.arrCart[indexPath.row].qty = qty
            self.tblCart.reloadRows(at: [indexPath], with: .fade)
            self.updateCart(itemId: self.arrCart[indexPath.row].itemid!,qty: String(qty))
            
        }
        
        cell?.actionBlockMinus = {
            var qty:Int = self.arrCart[indexPath.row].qty ?? 0
            
            if qty == 1 {
                cell?.lblQty.text = String(qty)
                 self.arrCart[indexPath.row].qty = qty
                 self.tblCart.reloadRows(at: [indexPath], with: .fade)
                 //self.updateCart(itemId: self.arrCart[indexPath.row].itemid!,qty: String(qty))
            }else{
                qty -= 1
                cell?.lblQty.text = String(qty)
                 self.arrCart[indexPath.row].qty = qty
                 self.tblCart.reloadRows(at: [indexPath], with: .fade)
                 self.updateCart(itemId: self.arrCart[indexPath.row].itemid!,qty: String(qty))
            }
        }
        
        return cell!
        
        }
        
        else{
            
            
            
            
            
            let cell = self.tblCart.dequeueReusableCell(withIdentifier: "MyCartCell", for: indexPath) as? MyCartCell
            //cell?.myCart = self.arrayOfDict[indexPath.row]
            
            cell?.lblSku.attributedText = "Sku: \(arrayOfDict[indexPath.row][SKU] ?? "")".withBoldText(text: "Sku:")
            cell?.lblQty.text="\(arrayOfDict[indexPath.row][QTY] ?? "")"
            cell? .lblPrice.text=priceFormat2("\(arrayOfDict[indexPath.row][PRICE] ?? "")")
            cell?.lblStoneDetail.attributedText="Stone Detail: \(arrayOfDict[indexPath.row][STONE_DETAIL] ?? "")".withBoldText(text: "Stone Detail:")
            cell?.lblMetalDetail.attributedText="Metal Detail: \(arrayOfDict[indexPath.row][METAL_DETAIL] ?? "")".withBoldText(text: "Metal Detail:")
            //
            cell?.imgProduct.sd_setImage(with: URL(string: (arrayOfDict[indexPath.row][PRODUCT_IMAGE])!), placeholderImage: UIImage(named: "Diamond-mela-mobile-logo.png"))
            
            print(arrayOfDict[indexPath.row][RING_SIZE])
            print(arrayOfDict[indexPath.row][BRACELET_SIZE])
            print(arrayOfDict[indexPath.row][BANGLE_SIZE])
            print(arrayOfDict[indexPath.row][PENDENT_SET_TYPE])
            
            if arrayOfDict[indexPath.row][RING_SIZE] != ""{
                cell?.lblSize.isHidden = false
                cell?.lblSize.attributedText="Ring Size: \(arrayOfDict[indexPath.row][RING_SIZE] ?? "")".withBoldText(text: "Ring Size:")
            }else if arrayOfDict[indexPath.row][BRACELET_SIZE] != ""{
                cell?.lblSize.isHidden = false
                cell?.lblSize.attributedText="Bracelet Size: \(arrayOfDict[indexPath.row][BRACELET_SIZE] ?? "")".withBoldText(text: "Bracelet Size:")
            }else if arrayOfDict[indexPath.row][BANGLE_SIZE] != ""{
                cell?.lblSize.isHidden = false
                cell?.lblSize.attributedText="Bangle Size: \(arrayOfDict[indexPath.row][BANGLE_SIZE] ?? "")".withBoldText(text: "Bangle Size:")
            }else if arrayOfDict[indexPath.row][PENDENT_SET_TYPE] != ""{
                cell?.lblSize.isHidden = false
                cell?.lblSize.attributedText="Pendent Size: \(arrayOfDict[indexPath.row][PENDENT_SET_TYPE] ?? "")".withBoldText(text: "Pendent Size:")
            }else{
                cell?.lblSize.isHidden = true
            }
                        
            if arrayOfDict[indexPath.row][PRODUCT_TYPE] == "simple" {
                cell?.btnPlus.isHidden = true
                cell?.btnMinus.isHidden = true
            }else{
                cell?.btnPlus.isHidden = false
                cell?.btnMinus.isHidden = false
            }
            
            
            cell?.actionBlockRemove = {
                
                
                let refreshAlert = UIAlertController(title: DELETE, message: ARE_U_SURE_DEL, preferredStyle: UIAlertController.Style.alert)
                
                refreshAlert.addAction(UIAlertAction(title: OK, style: .default, handler: { (action: UIAlertAction!) in
                    
                  
                    self.arrayOfDict.remove(at: indexPath.row)
                    userSessionData.set(self.arrayOfDict, forKey: CART_USERDEFAULTS)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    self.manageCart()
                    
                    
                    
                }))
                
                refreshAlert.addAction(UIAlertAction(title: CANCEL, style: .cancel, handler: { (action: UIAlertAction!) in
                    
                }))
                
                self.present(refreshAlert, animated: true, completion: nil)
                
                
                
            }
            
            cell?.actionBlockPlus = {
                var qty:Int = Int(self.arrayOfDict[indexPath.row][QTY] ?? "") ?? 0
                qty += 1
                cell?.lblQty.text = String(qty)
                
                self.arrayOfDict[indexPath.row][QTY] = String(qty)
                self.tblCart.reloadRows(at: [indexPath], with: .fade)
                userSessionData.set(self.arrayOfDict, forKey: CART_USERDEFAULTS)
                self.manageCart()
               // self.updateCart(itemId: self.arrCart[indexPath.row].itemid!,qty: String(qty))
                
            }
            
            cell?.actionBlockMinus = {
                var qty:Int = Int(self.arrayOfDict[indexPath.row][QTY] ?? "") ?? 0
                
                if qty == 1 {
                    cell?.lblQty.text = String(qty)
                    self.arrayOfDict[indexPath.row][QTY] = String(qty)
                    self.tblCart.reloadRows(at: [indexPath], with: .fade)
                    //self.updateCart(itemId: self.arrCart[indexPath.row].itemid!,qty: String(qty))
                }else{
                    qty -= 1
                    cell?.lblQty.text = String(qty)
                    self.arrayOfDict[indexPath.row][QTY] = String(qty)
                    self.tblCart.reloadRows(at: [indexPath], with: .fade)
                    userSessionData.set(self.arrayOfDict, forKey: CART_USERDEFAULTS)
                     self.manageCart()
                  //  self.updateCart(itemId: self.arrCart[indexPath.row].itemid!,qty: String(qty))
                }
            }
            
            return cell!
            
        }
      
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

