import UIKit
import ObjectMapper
import RappleProgressHUD
class OrderDetailVC: UIViewController {

    @IBOutlet weak var imgCancel: UIImageView!
    @IBOutlet weak var imgPrint: UIImageView!
    @IBOutlet weak var constraintTableHeight: NSLayoutConstraint!
    @IBOutlet weak var constraintMainHeight: NSLayoutConstraint!
    @IBOutlet weak var lblOrderStatus: UILabel!
    @IBOutlet weak var lblGrandTotal: UILabel!
    @IBOutlet weak var lblTax: UILabel!
    @IBOutlet weak var lblShippingCharge: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var tblOrderDetail: UITableView!
    @IBOutlet weak var lblPaymentMethod: UILabel!
    @IBOutlet weak var lblShippingMethod: UILabel!
    @IBOutlet weak var lblShippingAddress: UILabel!
    @IBOutlet weak var lblBillingAddress: UILabel!
    @IBOutlet weak var lblOrderDate: UILabel!
    
    @IBOutlet weak var buttonCancelOrder: UIButtonX!
    @IBOutlet weak var btnPrintOrder: UIButtonX!
    
    var orderId:String = ""
    var status:String = ""
    var arrOrderDetail = [OrderDetailItem.Order_item]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDownloadCartCount()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constraintMainHeight.constant = 900
        self.lblOrderStatus.text="Order Status: \(status)"
        
        
        if status == "Pending" {
            buttonCancelOrder.isEnabled = true
            btnPrintOrder.isEnabled = false
            imgPrint.tintColor = UIColor.gray
            
            
        }else if status == "Complete"{
            buttonCancelOrder.isEnabled = false
            btnPrintOrder.isEnabled = true
            imgCancel.tintColor = UIColor.gray
            
            
        }else if status == "Canceled"{
            buttonCancelOrder.isEnabled = false
            btnPrintOrder.isEnabled = false
            imgPrint.tintColor = UIColor.gray
            imgCancel.tintColor = UIColor.gray
        }
        
        
        
        self.getOrderDetail(orderId: orderId)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnPrintOrder(_ sender: Any) {
        self.printOrder(orderId: orderId, groupId: groupId)
    }
    
    @IBAction func btnCancelOrder(_ sender: Any) {
        self.cancelOrder(orderId: orderId)
    }
    
    @IBAction func btnCart(_ sender: Any) {
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSearch(_ sender: Any) {
        let search = self.storyboard?.instantiateViewController(withIdentifier: "SearchVC") as? SearchVC
        navigationController?.pushViewController(search!, animated: true)
    }
    
}


extension OrderDetailVC{
    
    func getOrderDetail(orderId:String){
        let par = ["orderid": orderId]
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiGetOrderDetail(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
                
            } else {
                let orderDetailData=Mapper<OrderDetailItem>().map(JSON: result)
                
                let data=Mapper<OrderDetailItem.Data>().mapArray(JSONArray: result["data"] as! [[String : Any]])
                
                self.arrOrderDetail=data[0].order_item!
                
//                self.arrOrderDetail=Mapper<OrderDetailItem.Order_item>().mapArray(JSONArray: result["order_item"] as! [[String : Any]])
                
                self.reloadTable()
                
                self.lblGrandTotal.text=priceFormat2(orderDetailData?.data?[0].order_grandtotal! ?? "")
                self.lblTax.text=priceFormat2(orderDetailData?.data?[0].oder_taxamount ?? "")
                self.lblShippingCharge.text=priceFormat2(orderDetailData?.data?[0].order_shippingamount ?? "")
                self.lblSubTotal.text=priceFormat2(orderDetailData?.data?[0].order_subtotal ?? "")
                
                self.lblPaymentMethod.text=orderDetailData?.data?[0].payment_method
                self.lblShippingMethod.text=orderDetailData?.data?[0].shipping_description
                self.lblShippingAddress.text=orderDetailData?.data?[0].shiiping_address
                self.lblBillingAddress.text=orderDetailData?.data?[0].billing_address
                self.lblOrderDate.text="Order Data: \(orderDetailData?.data?[0].order_date ?? "")"
                
          
            }
            
        }
    }
    
    func cancelOrder(orderId:String) {
        
        let par = ["orderid": orderId]
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiCancelOrder(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
                
            } else {
                
            }
            
        }
    }
    
    func printOrder(orderId:String,groupId:String) {
        
        let par = ["order_id": orderId, "customer_id":customerId,"group_id":groupId]
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiPrintOrder(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                let pdfUrl = result["pdf"] as? String
               
                
//                let printController = UIPrintInteractionController.shared
//
//                let printInfo = UIPrintInfo(dictionary:nil)
//                printInfo.outputType = UIPrintInfo.OutputType.general
//                printInfo.jobName = "Order invoice"
//                printInfo.duplex = UIPrintInfo.Duplex.none
//                printInfo.orientation = UIPrintInfo.Orientation.portrait
//
//                let link:URL = URL.init(string: pdfUrl!)!
//                print(link.absoluteString)
//                //New stuff
//               // printController.printPageRenderer = nil
//               // printController.printingItems = nil
//                printController.printingItem = link.absoluteString
//                //New stuff
//
//                printController.printInfo = printInfo
//                printController.showsPageRange = true
//                printController.showsNumberOfCopies = true
//               // printController.present(animated: true, completionHandler: nil)
//
//
//                printController.present(animated: true, completionHandler: nil)
                
//                printController.present(from: btnPrintOrder, animated: true, completionHandler: nil)
                
                
                let print = self.storyboard?.instantiateViewController(withIdentifier: "PrintVC") as? PrintVC
                print?.printFile = pdfUrl!
                self.navigationController?.pushViewController(print!, animated: true)
              
                
            }
            
        }
    }
    
    func reloadTable() {
        if self.arrOrderDetail.count > 0 {
            //            self.lblNoData.isHidden = true
            
            let totalHeight:Int = self.arrOrderDetail.count * 200
            
            constraintTableHeight.constant = CGFloat(60 + totalHeight)
            
            
            self.constraintMainHeight.constant = CGFloat(700 + totalHeight)
            
        } else {
            //            self.lblNoData.isHidden = false
           
           
            
        }
        self.tblOrderDetail.reloadData()
    }
    
}


extension OrderDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrOrderDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = self.tblOrderDetail.dequeueReusableCell(withIdentifier: "OrderDetailCell", for: indexPath) as? OrderDetailCell
        
        
        cell?.orderDetailData = self.arrOrderDetail[indexPath.row]
        
       
        
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
