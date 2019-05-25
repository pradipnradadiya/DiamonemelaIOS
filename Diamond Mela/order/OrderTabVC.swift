import UIKit
import ObjectMapper
import RappleProgressHUD
class OrderTabVC: UIViewController {

    @IBOutlet weak var tblOrder: UITableView!
    @IBOutlet weak var viewCustomerOrder: UIView!
    @IBOutlet weak var viewMyOrder: UIView!
    @IBOutlet weak var viewAllOrder: UIView!
    
    var orderType:String="AllOrder"
    
    var pageCount: Int = 1
    var arrOrders = [OrderItem.Data]()
    let refreshControl = UIRefreshControl()
    var hasMoredata: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getOrders(showLoader: true)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack(_ sender: Any) {
    }
    
    @IBAction func btnSearch(_ sender: Any) {
    }
    
    @IBAction func btnCart(_ sender: Any) {
    }
    
    @IBAction func btnAllOrder(_ sender: Any) {
        orderType="AllOrder"
        viewAllOrder.backgroundColor=UIColor.white
        viewMyOrder.backgroundColor=UIColor.black
        viewCustomerOrder.backgroundColor=UIColor.black
        refresh()
         self.getOrders(showLoader: true)
    }
    
    @IBAction func btnMyOrder(_ sender: Any) {
        orderType="MyOrder"
        viewAllOrder.backgroundColor=UIColor.black
        viewMyOrder.backgroundColor=UIColor.white
        viewCustomerOrder.backgroundColor=UIColor.black
        refresh()
         self.getOrders(showLoader: true)
    }
    
    @IBAction func btnCustomerOrder(_ sender: Any) {
        orderType="CustomerOrder"
        viewAllOrder.backgroundColor=UIColor.black
        viewMyOrder.backgroundColor=UIColor.black
        viewCustomerOrder.backgroundColor=UIColor.white
        refresh()
         self.getOrders(showLoader: true)
    }
}

extension OrderTabVC{
    
    func getOrders(showLoader: Bool = false) {
        if showLoader {
            RESpinner.shared.show(view: self.view)
        }
        let par = ["customer_id": customerId,
                   "group_id":"6",
                   "order":orderType,
                   "pagesize":String(pageCount)]
        
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiGetOrder(params:par as [String : AnyObject]) { (result) in
            
            RESpinner.shared.hide()
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
                
            } else {
//                let orders=Mapper<OrderItem>().map(JSON: result)
                
                let orderList=Mapper<OrderItem.Data>().mapArray(JSONArray: result["data"] as! [[String : Any]])
                
                if orderList.count < 10 {
                    self.hasMoredata = false
                } else {
                    self.hasMoredata = true
                }
                
                if self.pageCount == 1 {
                    self.arrOrders.removeAll()
                    self.tblOrder.reloadData()
                    self.arrOrders = orderList
                } else {
                    self.arrOrders.append(contentsOf: orderList)
                }
                self.reloadTable()
                self.pageCount += 1
                print(self.pageCount)
                
            }
            
        }
    }
    
    func reloadTable() {
        if self.arrOrders.count > 0 {
            //            self.lblNoData.isHidden = true
        } else {
            //            self.lblNoData.isHidden = false
        }
        self.tblOrder.reloadData()
    }
    
    @objc func refresh() {
        self.pageCount = 1
        self.hasMoredata = false
        self.arrOrders.removeAll()
        self.tblOrder.reloadData()
        //self.getOrders(showLoader: true)
    }
    
}


extension OrderTabVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hasMoredata ? self.arrOrders.count + 1 : self.arrOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if hasMoredata && indexPath.row == self.arrOrders.count {
            let cell = self.tblOrder.dequeueReusableCell(withIdentifier: "LoaderCell", for: indexPath) as? LoaderCell
            cell?.indicator.startAnimating()
            //  self.getData()
            self.getOrders()
            return cell!
            
        }
        
        let cell = self.tblOrder.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as? OrderCell
        cell?.orderData = self.arrOrders[indexPath.row]
        
        cell?.rowPosition=indexPath.row
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if hasMoredata && indexPath.row == self.arrOrders.count {
            return
        }
        
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

