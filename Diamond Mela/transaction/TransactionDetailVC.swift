
import UIKit

class TransactionDetailVC: UIViewController {

    var arrTransactionItem = [TransactionItem.Order_item]()
    
    @IBOutlet weak var tblTransactionDetail: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadTable()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func reloadTable() {
        if self.arrTransactionItem.count > 0 {
            //            self.lblNoData.isHidden = true
        } else {
            //            self.lblNoData.isHidden = false
        }
        self.tblTransactionDetail.reloadData()
    }
    

}

extension TransactionDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrTransactionItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tblTransactionDetail.dequeueReusableCell(withIdentifier: "TransactionDetailCell", for: indexPath) as? TransactionDetailCell
        cell?.transactionDetail = self.arrTransactionItem[indexPath.row]
       
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

