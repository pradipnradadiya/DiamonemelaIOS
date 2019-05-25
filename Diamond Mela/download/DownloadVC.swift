import UIKit
import ObjectMapper
import RappleProgressHUD

class DownloadVC: UIViewController {

    var pageCount: Int = 1
    var arrDownload = [DownloadItem.Data]()
    let refreshControl = UIRefreshControl()
    var hasMoredata: Bool = false
    
    
    
    @IBOutlet weak var tblDownloadProduct: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getDownloadList(showLoader: true)
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func btnWithPrice(_ sender: Any) {
    }
    
    @IBAction func btnWithoutPrice(_ sender: Any) {
    }
    
    @IBAction func btnCart(_ sender: Any) {
    }
    
    @IBAction func btnSearch(_ sender: Any) {
    }
    @IBAction func btnDownloadAll(_ sender: Any) {
    }
    
    @IBAction func btnDeleteAll(_ sender: Any) {
    }
    
    @IBAction func btnBack(_ sender: Any) {
    }
    
}

extension DownloadVC {
    
    func getDownloadList(showLoader: Bool = false) {
        
        if showLoader {
            RESpinner.shared.show(view: self.view)
        }
        
        let par = ["customer_id": customerId, "pagesize":pageCount] as [String : Any]
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiGetDownloadProductList(params:par as [String : AnyObject]) { (result) in
            
            RESpinner.shared.hide()
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
                
            } else {
                let downloadList=Mapper<DownloadItem>().map(JSON: result)
                
                let downloadData=Mapper<DownloadItem.Data>().mapArray(JSONArray: result["data"] as! [[String : Any]])
                
                if downloadData.count < pagesize {
                    self.hasMoredata = false
                } else {
                    self.hasMoredata = true
                }
                
                if self.pageCount == 1 {
                    self.arrDownload.removeAll()
                    self.tblDownloadProduct.reloadData()
                    self.arrDownload = downloadData
                } else {
                    self.arrDownload.append(contentsOf: downloadData)
                }
                self.reloadTable()
                self.pageCount += 1
                
                
                
            }
            
        }
    }
    
    
    func reloadTable() {
        if self.arrDownload.count > 0 {
            //            self.lblNoData.isHidden = true
        } else {
            //            self.lblNoData.isHidden = false
        }
        self.tblDownloadProduct.reloadData()
    }
    
    @objc func refresh() {
        self.pageCount = 1
        self.hasMoredata = false
        self.arrDownload.removeAll()
        self.tblDownloadProduct.reloadData()
        self.getDownloadList(showLoader: true)
    }
    
}

extension DownloadVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hasMoredata ? self.arrDownload.count + 1 : self.arrDownload.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if hasMoredata && indexPath.row == self.arrDownload.count {
            let cell = self.tblDownloadProduct.dequeueReusableCell(withIdentifier: "LoaderCell", for: indexPath) as? LoaderCell
            cell?.indicator.startAnimating()
            //  self.getData()
            self.getDownloadList()
            return cell!
            
        }
        
        let cell = self.tblDownloadProduct.dequeueReusableCell(withIdentifier: "DownloadListCell", for: indexPath) as? DownloadListCell
        //        cell?.QA = self.arrQA[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if hasMoredata && indexPath.row == self.arrDownload.count {
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

