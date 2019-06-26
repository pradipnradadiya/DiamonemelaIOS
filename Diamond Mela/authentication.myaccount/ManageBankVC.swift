import UIKit
import ObjectMapper
import RappleProgressHUD
class ManageBankVC: UIViewController {

    
    var arrManageBank = [BankItem.Data]()
    @IBOutlet weak var tblManageBank: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDownloadCartCount()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getBankList(showLoader: true)
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


extension ManageBankVC{
    
    func getBankList(showLoader: Bool = false) {
//        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        
        if showLoader {
            RESpinner.shared.show(view: self.view)
        }
        
        let par = ["customer_id": customerId]
        
        ApiManager.shared.apiListBank(params:par as [String : AnyObject]) { (result) in
            
//            RappleActivityIndicatorView.stopAnimation()
             RESpinner.shared.hide()
            let status = result[STATUS_CODE] as? String
            
            if status == FAILURE_CODE || status == nil {
               
            } else {
                let bankData=Mapper<BankItem.Data>().mapArray(JSONArray: result["data"] as! [[String : Any]])
                self.tblManageBank.reloadData()
                self.arrManageBank = bankData
                
                self.reloadTable()
                
                
            }
            
        }
    }
    
    func deleteBank(bankId:String){
        let par = ["bank_id": bankId]
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiDeleteBankDetail(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                
            }
            
        }
    }
    
    func editBankDetail(bankId:String,customerId:String,bankName:String,bankAccountNumber:String,bankAccountHolder:String,ifscCode:String,branchName:String){
        let par = ["bank_id": bankId,
                   "customer_id":customerId,
                   "bank_name":bankName,
                   "bank_account_number":bankAccountNumber,
                   "bank_account_holder":bankAccountHolder,
                   "ifsc_code":ifscCode,
                   "branch_name":branchName]
        
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiEditBankDetail(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                
            }
            
        }
        
    }
    
    func reloadTable() {
        if self.arrManageBank.count > 0 {
            //            self.lblNoData.isHidden = true
        } else {
            //            self.lblNoData.isHidden = false
        }
        self.tblManageBank.reloadData()
    }
    
}

extension ManageBankVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrManageBank.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = self.tblManageBank.dequeueReusableCell(withIdentifier: "ManageBankCell", for: indexPath) as? ManageBankCell
        cell?.bankData = self.arrManageBank[indexPath.row]
        cell?.actionBlockDelete = {
            
            // Declare Alert
            let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to delete bank?", preferredStyle: .alert)
            
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                
                print("delete click")
                self.deleteBank(bankId: self.arrManageBank[indexPath.row].bank_id!)
                self.arrManageBank.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            })
            
            // Create Cancel button with action handlder
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
                print("Cancel button click...")
            }
            
            //Add OK and Cancel button to dialog message
            dialogMessage.addAction(ok)
            dialogMessage.addAction(cancel)
            
            // Present dialog message to user
            self.present(dialogMessage, animated: true, completion: nil)
      
            
        }
        
        cell?.actionBlockEdit = {
            print("edit click")
            
            //1. Create the alert controller.
            let alert = UIAlertController(title: "Bank Detail", message: "Edit a bank detail", preferredStyle: .alert)
            
            //2. Add the text field. You can configure it however you need.
            alert.addTextField { (textField) in
                textField.text = self.arrManageBank[indexPath.row].bank_name
            }
            
            alert.addTextField { (textField) in
                textField.text = self.arrManageBank[indexPath.row].bank_account_number
            }
            
            alert.addTextField { (textField) in
                textField.text = self.arrManageBank[indexPath.row].bank_account_holder
            }
            
            alert.addTextField { (textField) in
                textField.text = self.arrManageBank[indexPath.row].ifsc_code
            }
            
            alert.addTextField { (textField) in
                textField.text = self.arrManageBank[indexPath.row].branch_name
            }
            
            // 3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                self.editBankDetail(bankId: self.arrManageBank[indexPath.row].bank_id!, customerId: customerId, bankName: alert!.textFields![0].text!, bankAccountNumber: alert!.textFields![1].text!, bankAccountHolder: alert!.textFields![2].text!, ifscCode: alert!.textFields![3].text!, branchName: alert!.textFields![4].text!)
                
                
                self.arrManageBank[indexPath.row].bank_name = alert!.textFields![0].text!
                self.arrManageBank[indexPath.row].bank_account_number = alert!.textFields![1].text!
                self.arrManageBank[indexPath.row].bank_account_holder = alert!.textFields![2].text!
                self.arrManageBank[indexPath.row].ifsc_code = alert!.textFields![3].text!
                self.arrManageBank[indexPath.row].branch_name = alert!.textFields![4].text!
                
                let indexPath = IndexPath(item: indexPath.row, section: 0)
                tableView.reloadRows(at: [indexPath], with: .fade)
                
                
            }))
            
             alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { [weak alert] (_) in
                
                 }))
            
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)
            
            
            
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

