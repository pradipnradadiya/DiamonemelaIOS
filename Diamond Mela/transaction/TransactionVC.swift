import UIKit
import ObjectMapper
import RappleProgressHUD


class TransactionVC: UIViewController {

    @IBOutlet weak var tblTransaction: UITableView!
    
    
    var pageCount: Int = 1
    var arrTransaction = [TransactionItem.Data]()
    let refreshControl = UIRefreshControl()
    var hasMoredata: Bool = false
    @IBOutlet weak var lblTotalDebit: UILabel!
    @IBOutlet weak var lblCredit: UILabel!
    @IBOutlet weak var lblDeposit: UILabel!
    @IBOutlet weak var lblDebit: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        getTransactionList(showLoader: true)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCart(_ sender: Any) {
    }
    @IBAction func btnSearch(_ sender: Any) {
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension TransactionVC {
    
    func getTransactionList(showLoader: Bool = false) {
        
        if showLoader {
            RESpinner.shared.show(view: self.view)
        }
        
        let par = ["customer_id": customerId, "pagesize":pageCount] as [String : Any]
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiGetTransactionList(params:par as [String : AnyObject]) { (result) in
            
            RESpinner.shared.hide()
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
                
            } else {
                let transactionList=Mapper<TransactionItem>().map(JSON: result)
                self.lblTotalDebit.text="\(transactionList?.total_debit ?? 0)"
                self.lblCredit.text="\(transactionList?.total_credit ?? 0)"
                self.lblDeposit.text="\(transactionList?.total_deposite ?? 0)"
                self.lblDebit.text="\(transactionList?.total_debit ?? 0)"
                
                
                
                let trasactionData=Mapper<TransactionItem.Data>().mapArray(JSONArray: result["data"] as! [[String : Any]])
                
                if trasactionData.count < 10 {
                    self.hasMoredata = false
                } else {
                    self.hasMoredata = true
                }
                
                if self.pageCount == 1 {
                    self.arrTransaction.removeAll()
                    self.tblTransaction.reloadData()
                    self.arrTransaction = trasactionData
                } else {
                    self.arrTransaction.append(contentsOf: trasactionData)
                }
                self.reloadTable()
                self.pageCount += 1
                
            }
            
        }
    }
    
    func reloadTable() {
        if self.arrTransaction.count > 0 {
//            self.lblNoData.isHidden = true
        } else {
//            self.lblNoData.isHidden = false
        }
        self.tblTransaction.reloadData()
    }
    
    @objc func refresh() {
        self.pageCount = 1
        self.hasMoredata = false
        self.arrTransaction.removeAll()
        self.tblTransaction.reloadData()
        self.getTransactionList(showLoader: true)
    }
    
}

extension TransactionVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hasMoredata ? self.arrTransaction.count + 1 : self.arrTransaction.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if hasMoredata && indexPath.row == self.arrTransaction.count {
            let cell = self.tblTransaction.dequeueReusableCell(withIdentifier: "LoaderCell", for: indexPath) as? LoaderCell
            cell?.indicator.startAnimating()
          //  self.getData()
            self.getTransactionList()
            return cell!
            
        }
        
        let cell = self.tblTransaction.dequeueReusableCell(withIdentifier: "TransactionListCell", for: indexPath) as? TransactionListCell
        cell?.transactionData = self.arrTransaction[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if hasMoredata && indexPath.row == self.arrTransaction.count {
            return
        }
        
        if self.arrTransaction[indexPath.row].order_item?.count == 0 ||  self.arrTransaction[indexPath.row].order_item == nil{
            
        }else{
            let detail = self.storyboard?.instantiateViewController(withIdentifier: "TransactionDetailVC") as? TransactionDetailVC
            detail?.arrTransactionItem=self.arrTransaction[indexPath.row].order_item!
                   
            self.navigationController?.pushViewController(detail!, animated: true)
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

