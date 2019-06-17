import UIKit
import ObjectMapper
import RappleProgressHUD

class SelectStateVC: UIViewController {

    @IBOutlet weak var tblState: UITableView!
    @IBOutlet weak var btnDone: UIBarButtonItem!
    
    var arrState = [StateResponse.Data]()
    var countryId:String = ""
    var stateName:String = ""
    var regionId:String = ""
    
    typealias CompletionBloack = (String, String) -> Void
    
    var myCompletion: CompletionBloack?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getState(country_id: countryId)
        // Do any additional setup after loading the view.
    }
 
    @IBAction func btnBack(_ sender: Any) {
//        if self.myCompletion != nil {
//            self.myCompletion!(stateName, regionId)
//        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnDone(_ sender: Any) {
        if self.myCompletion != nil {
            self.myCompletion!(stateName, regionId)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
}


extension SelectStateVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrState.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tblState.dequeueReusableCell(withIdentifier: "StateCell", for: indexPath) as? StateCell
        
        cell?.state = self.arrState[indexPath.row]
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        stateName = self.arrState[indexPath.row].name!
        regionId = self.arrState[indexPath.row].region_id!
        self.btnDone.isEnabled = true
        
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

extension SelectStateVC {
    
    func getState(country_id : String){
        let par = ["country_id": country_id]
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiGetState(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
                
            } else {
                let stateList=Mapper<StateResponse>().map(JSON: result)
                self.arrState = stateList?.data ?? []
                self.reloadTable()
            }
            
        }
    }
    
    
    func reloadTable()  {
        
            if self.arrState.count > 0 {
                //            self.lblNoData.isHidden = true
            } else {
                //            self.lblNoData.isHidden = false
            }
            self.tblState.reloadData()
        
    }
}
