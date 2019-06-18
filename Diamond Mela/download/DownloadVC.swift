import UIKit
import ObjectMapper
import RappleProgressHUD
import Photos

class DownloadVC: UIViewController {

    @IBOutlet weak var btnWithPrice: UIButton!
    @IBOutlet weak var btnWithoutPrice: UIButton!
    var pageCount: Int = 1
    var arrDownload = [DownloadItem.Data]()
    let refreshControl = UIRefreshControl()
    
    var selectArr = [Int]()
    
    var hasMoredata: Bool = false
    
    var flag:String = "1"
    var productIds:String = ""
    
    @IBOutlet weak var tblDownloadProduct: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getDownloadList(showLoader: true)
        
        
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func btnWithPrice(_ sender: Any) {
        flag="1"
        btnWithPrice.setImage(UIImage(named: "radio-select"), for: .normal)
        btnWithoutPrice.setImage(UIImage(named: "radio"), for: .normal)
    }
    
    @IBAction func btnWithoutPrice(_ sender: Any) {
        flag="0"
        btnWithPrice.setImage(UIImage(named: "radio"), for: .normal)
        btnWithoutPrice.setImage(UIImage(named: "radio-select"), for: .normal)
    }
    
    @IBAction func btnCart(_ sender: Any) {
    }
    
    @IBAction func btnSearch(_ sender: Any) {
    }
    @IBAction func btnDownloadAll(_ sender: Any) {
        var i: Int = 0
        for (prodictId) in arrDownload.enumerated(){
            if prodictId.element.isSelected == true{
                print(prodictId.element.isSelected as Any)
                productIds.append("\(prodictId.element.product_id!),")
                
                
            }else{
                
            }
            i += 1
            
        }
        
         self.downloadAllProduct(customerId: customerId, productId: productIds, price: flag)
        //self.downloadAllProduct(customerId: customerId, productId: productIds, price: flag)
        
    }
    
    @IBAction func btnDeleteAll(_ sender: Any) {
     
        self.selectArr.removeAll()
        var i:Int = 0
        for (prodictId) in arrDownload.enumerated(){
            
            if prodictId.element.isSelected == true{
                print(prodictId.element.isSelected as Any)
                productIds.append("\(prodictId.element.product_id!),")
                selectArr.append(i)
              
                
                
                
                //self.arrDownload.remove(at: indexPath.row)
             //   tableView.deleteRows(at: [indexPath], with: .fade)
             //   tblDownloadProduct.deleteRows(at: IndexPath[i], with: .fade)
              // self.arrDownload.remove(at: i)
                
            }else{
                
            }
            i += 1
           
         
        }
        
        self.deleteAllProduct(customerId: customerId, productId: productIds)
        
       // self.tblDownloadProduct.reloadData()
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}



extension DownloadVC {
    
    func saveToImage(filename:String) {
        DispatchQueue.global(qos: .background).async {
            RappleActivityIndicatorView.startAnimatingWithLabel("Please wait image is saved in photos.")
            if let url = URL(string: filename),
                let urlData = NSData(contentsOf: url) {
                let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
                let filePath="\(documentsPath)/tempFile.png"
                DispatchQueue.main.async {
                    urlData.write(toFile: filePath, atomically: true)
                    PHPhotoLibrary.shared().performChanges({
//                        PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: <#T##URL#>)
                        PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: URL(fileURLWithPath: filePath))
                        
                    }) { completed, error in
                        if completed {
                            print("image is saved!")
                            RappleActivityIndicatorView.stopAnimation()
                        }
                    }
                }
            }
        }
    }
    
 
    
    func downloadAllProduct(customerId:String , productId:String,price:String){
        
        let par = ["customer_id": customerId, "product_ids":productId,"price":price] as [String : Any]
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiDownloadAllProductList(params:par as [String : AnyObject]) { (result) in
           
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
                
            } else {
                //let image = result["image"] as? String
                let dData = Mapper<ImageDownloadResponse>().map(JSON: result)
               // self.downloadImage(url: image!)
                print(dData?.image![0] as Any)
                self.saveToImage(filename: (dData?.image![0])!)
            }
            
        }
    }
    
    func deleteAllProduct(customerId:String , productId:String){
        let par = ["customer_id": customerId, "product_ids":productId] as [String : Any]
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiDeleteAllProductList(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
          
            } else {
                
                
                
                self.selectArr.reverse()
                    var i: Int = 0
                for _ in self.selectArr{
                        self.arrDownload.remove(at: self.selectArr[i])
                        i += 1
                    }
                
                self.tblDownloadProduct.reloadData()
             
               
            }
            
        }
    }
    
    
    
    
    func getDownloadList(showLoader: Bool = false) {
        
        if showLoader {
            RESpinner.shared.show(view: self.view)
        }
        
        let par = ["customer_id": customerId, "pagesize":pageCount] as [String : Any]
//        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiGetDownloadProductList(params:par as [String : AnyObject]) { (result) in
            
            RESpinner.shared.hide()
//            RappleActivityIndicatorView.stopAnimation()
            
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
        
            cell?.downloadData = self.arrDownload[indexPath.row]
        
        cell?.actionBlockDelete = {
            self.deleteAllProduct(customerId: customerId, productId: self.arrDownload[indexPath.row].product_id!)
            self.arrDownload.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        cell?.actionBlockDownload = {
            self.downloadAllProduct(customerId: customerId, productId: self.arrDownload[indexPath.row].product_id!, price: self.flag)
            
        }
        
        cell?.actionBlockSelect = {
            
            if self.arrDownload[indexPath.row].isSelected == true {
                self.arrDownload[indexPath.row].isSelected = false
            }else{
                 self.arrDownload[indexPath.row].isSelected = true
            }
           self.tblDownloadProduct.reloadRows(at: [indexPath], with: .automatic)
            
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if hasMoredata && indexPath.row == self.arrDownload.count {
            return
        }
        
        
                let download = self.storyboard?.instantiateViewController(withIdentifier: "DownloadDetailVC") as? DownloadDetailVC
                download?.downloadItem = self.arrDownload[indexPath.row]
        //        qadetail?.qid = self.arrQA[indexPath.row].iD!
                self.navigationController?.pushViewController(download!, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

