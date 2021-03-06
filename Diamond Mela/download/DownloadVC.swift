import UIKit
import ObjectMapper
import RappleProgressHUD
import Photos

class DownloadVC: UIViewController {

    var deleteProductFlag:Int = 0
   
    
    @IBOutlet weak var viewNoData: UIView!
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDownloadCartCount()
    }
    
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
        let search = self.storyboard?.instantiateViewController(withIdentifier: "SearchVC") as? SearchVC
        navigationController?.pushViewController(search!, animated: true)
    }
    
    
    @IBAction func btnDownloadAll(_ sender: Any) {
        
        // Declare Alert
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to Download  products in Photos?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button click...")
            var i: Int = 0
            for (prodictId) in self.arrDownload.enumerated(){
                if prodictId.element.isSelected == true{
                    print(prodictId.element.isSelected as Any)
                    self.productIds.append("\(prodictId.element.product_id!),")
                    
                }else{
                    
                }
                i += 1
                
            }
            
            let photos = PHPhotoLibrary.authorizationStatus()
            if photos == .notDetermined {
                PHPhotoLibrary.requestAuthorization({status in
                    if status == .authorized{
                       self.downloadAllProduct(customerId: customerId, productId: self.productIds, price: self.flag)
                    } else {
                        self.showAlert(title: "Alert", message: "Photos permission deniad, so product not download in gallery.")
                    }
                })
            }else{
                self.downloadAllProduct(customerId: customerId, productId: self.productIds, price: self.flag)
            }
     
            
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
        
        
       
        //self.downloadAllProduct(customerId: customerId, productId: productIds, price: flag)
        
    }
    
    @IBAction func btnDeleteAll(_ sender: Any) {
     
        
        // Declare Alert
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to Delete Download Products?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button click...")
            
            self.deleteProductFlag = 1
            
            self.selectArr.removeAll()
            var i:Int = 0
            
            for (prodictId) in self.arrDownload.enumerated(){
                
                if prodictId.element.isSelected == true{
                    print(prodictId.element.isSelected as Any)
                    self.productIds.append("\(prodictId.element.product_id!),")
                    self.selectArr.append(i)
             
                }else{
                    
                }
                i += 1
                
                
            }
            
            self.deleteAllProduct(customerId: customerId, productId: self.productIds)
            
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
        
        
       // self.tblDownloadProduct.reloadData()
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension DownloadVC {
    func random(_ n: Int) -> String
    {
        let a = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        
        var s = ""
        
        for _ in 0..<n
        {
            let r = Int(arc4random_uniform(UInt32(a.characters.count)))
            
            s += String(a[a.index(a.startIndex, offsetBy: r)])
        }
        
        return s
        
    }
    func saveToImage(filename:String) {
        
        
        DispatchQueue.global(qos: .background).async {
            RappleActivityIndicatorView.startAnimatingWithLabel("Please wait image is saved in photos.")
            if let url = URL(string: filename),
                let urlData = NSData(contentsOf: url) {
                let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
                let rand:String = self.random(10)
                
                let filePath="\(documentsPath)/\(rand)tempFile.png"
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
               
                let downloadData = dData?.image
                
                var j:Int = 0
                for _ in self.arrDownload{
                  
                    self.arrDownload[j].isSelected = false
                    j += 1
                  
                }
                self.tblDownloadProduct.reloadData()
                
                var i:Int = 0
                for _ in downloadData!{
                     print(dData?.image![i] as Any)
                      self.saveToImage(filename: (dData?.image![i])!)
                        i += 1
                }
                
              
                
                
                
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
                
                if self.deleteProductFlag == 1{
                    if self.selectArr.isEmpty{
                        self.arrDownload.removeAll()
                        self.reloadTable()
                        self.deleteProductFlag = 0
                    }
                }
                
                
                
                
                
             
               
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
                self.viewNoData.isHidden = false
                
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
                        self.viewNoData.isHidden = true
        } else {
                        self.viewNoData.isHidden = false
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
           
            let photos = PHPhotoLibrary.authorizationStatus()
            if photos == .notDetermined {
                PHPhotoLibrary.requestAuthorization({status in
                    if status == .authorized{
                        self.downloadAllProduct(customerId: customerId, productId: self.arrDownload[indexPath.row].product_id!, price: self.flag)
                    } else {
                        self.showAlert(title: "Alert", message: "Photos permission deniad, so product not download in gallery.")
                    }
                })
            }else{
                 self.downloadAllProduct(customerId: customerId, productId: self.arrDownload[indexPath.row].product_id!, price: self.flag)
            }
            
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

