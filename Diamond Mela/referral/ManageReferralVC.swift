import UIKit
import ObjectMapper
import RappleProgressHUD
class ManageReferralVC: UIViewController {

    
    var arrReferral = [ReferralItem.Data]()
    
    @IBOutlet weak var tblManageReferral: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getReferralList(showLoader: true)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDownloadCartCount()
    }
    
    
    @IBAction func btnCart(_ sender: Any) {
    }
    @IBAction func btnSearch(_ sender: Any) {
        let search = self.storyboard?.instantiateViewController(withIdentifier: "SearchVC") as? SearchVC
        navigationController?.pushViewController(search!, animated: true)
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnManageReferral(_ sender: Any) {
    }
    @IBAction func btnAddReferral(_ sender: Any) {
        let manageReferral = self.storyboard?.instantiateViewController(withIdentifier: "CreateReferralVC") as? CreateReferralVC
        manageReferral?.myCompletion = { sdas, ds in
            print(sdas)
        }
        self.navigationController?.pushViewController(manageReferral!, animated: true)
        //self.navigationController?.popViewController(animated: true)
    }
    
}
extension ManageReferralVC{
    
    func getReferralList(showLoader: Bool = false)  {
        
        if showLoader {
            RESpinner.shared.show(view: self.view)
        }
        
        let par = ["customer_id": customerId]
//        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiReferralList(params:par as [String : AnyObject]) { (result) in
             RESpinner.shared.hide()
//            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                             
                
            } else {
                let referralData=Mapper<ReferralItem.Data>().mapArray(JSONArray: result["data"] as! [[String : Any]])
                    self.tblManageReferral.reloadData()
                    self.arrReferral = referralData
                    self.reloadTable()
               
            }
            
        }
    }
    
    
    func deleteReferral(referralCustomerId:String){
       
        let par = ["referral_customer_id": referralCustomerId]
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiDeleteReferral(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                
            }
            
        }
        
    }
    
    func reloadTable() {
        if self.arrReferral.count > 0 {
            //            self.lblNoData.isHidden = true
        } else {
            //            self.lblNoData.isHidden = false
        }
        self.tblManageReferral.reloadData()
    }
    
}


extension ManageReferralVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrReferral.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = self.tblManageReferral.dequeueReusableCell(withIdentifier: "ReferralListCell", for: indexPath) as? ReferralListCell
            cell?.referralData = self.arrReferral[indexPath.row]
        cell?.actionBlockDelete =  {
            
            // Declare Alert
            let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to delete Referrals?", preferredStyle: .alert)
            
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button click...")
                
                self.deleteReferral(referralCustomerId: self.arrReferral[indexPath.row].entity_id!)
                self.arrReferral.remove(at: indexPath.row)
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

