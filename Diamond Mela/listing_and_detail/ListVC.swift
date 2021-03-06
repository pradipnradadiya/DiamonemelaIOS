import UIKit
import ObjectMapper
import RappleProgressHUD

class ListVC: UIViewController {

    @IBOutlet weak var viewNoData: UIView!
    var pageCount: Int = 1
    var arrList = [ListItem.Data]()
    
    var addToDownloadFlag : Int = 0
    var filterData = [SortFilterItem.Data]()
    let refreshControl = UIRefreshControl()
    var hasMoredata: Bool = false
    var headerTitle: String?=""
    var id:String?=""
    
    var price:String = ""
    var gold_purity:String = ""
    var diamond_quality:String = ""
    var diamond_shape:String = ""
    var sku:String = ""
    var availability:String = ""
    var sort_by:String = "";
    
    var sheetData = [SortFilterItem.Sort_by]()
    
    @IBOutlet weak var gridList: UICollectionView!
    @IBOutlet weak var btnfilter: UIButtonX!
    @IBOutlet weak var btnsort: UIButtonX!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        
        self.navigationItem.title=headerTitle
        
        
        
        if id == "search"{
            self.searchProduct(searchTerm: headerTitle!, page: String(pageCount),showLoader: true)
        }else{
            self.getSortFilter(url: Endpoint.getSortFilter.url)
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ProductDetailVC.caratValue = "14K"
        ProductDetailVC.metalValue = "Yellow Gold"
        ProductDetailVC.diamondValue = "SI-IJ"
        ProductDetailVC.ringValue = "12"
        ProductDetailVC.braceletProductValue = ""
        ProductDetailVC.bangleProductValue = ""
        ProductDetailVC.pendentValue = ""
        ProductDetailVC.bangleProductId = ""
        ProductDetailVC.braceletProductId = ""
        ProductDetailVC.pendentProId = ""
        ProductDetailVC.ringOptionId = ""
        ProductDetailVC.ringOptionTypeId = ""
        
        getDownloadCartCount()
    
        if FilterVC.filterFlag == 1{
            
            self.pageCount = 1
            self.arrList.removeAll()
            self.hasMoredata = false
            
            for (key, value) in FilterVC.dict {
                print("\(key): \(value)")
                
                if ("price" == key){
                    price=value as! String
                }else if("gold_purity" == key){
                    gold_purity=value as! String
                }else if("diamond_quality" == key){
                    diamond_quality=value as! String
                }else if("diamond_shape" == key){
                    diamond_shape=value as! String
                }else if("sku" == key){
                    sku=value as! String
                }else if("availability" == key){
                    availability=value as! String
                }
            }
            
            
            if (UserDefaults.standard.string(forKey: USER_SESSION_DATA_KEY)) != nil {
                self.getCategoryProduct(categoryId: id!, groupId: groupId, page: String(pageCount), price: price, gold_purity: gold_purity, diamond_quality: diamond_quality, diamond_shape: diamond_shape, sku: sku, availability: availability, sort_by: sort_by,showLoader: true)
            }else{
                self.getCategoryProduct(categoryId: id!, groupId: "", page: String(pageCount), price: price, gold_purity: gold_purity, diamond_quality: diamond_quality, diamond_shape: diamond_shape, sku: sku, availability: availability, sort_by: sort_by,showLoader: true)
            }
        }
    }
    
    
    
    @IBAction func btnCart(_ sender: Any) {
        
    }
    
    @IBAction func btnFilter(_ sender: Any) {
        
        let filter = self.storyboard?.instantiateViewController(withIdentifier: "FilterVC") as? FilterVC
        //filter?.arrFilterData = filterData
        self.navigationController?.pushViewController(filter!, animated: true)
        
    }
    
    @IBAction func btnSortBy(_ sender: Any) {
        self.openSortPopup()
    }
    
    @IBAction func btnDownload(_ sender: Any) {
        
        var downloadString:String = ""
        var i:Int = 0
        var count:Int = 0
        for _ in self.arrList {
            
            
            if self.arrList[i].download_flag == 0{
                downloadString.append("\(self.arrList[i].entity_id ?? ""),")
                count += 1
            }
            
            i += 1
            
        }
        
        if downloadString == ""{
            showAlert(title: "", message: "Loaded Product is allready downlodaed,scroll down and download.")
        }else{
            
            let alert = UIAlertController(title: "Download Product", message: "Are you sure want to add \(count) products in cart.?", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: OK, style: UIAlertAction.Style.default, handler: { _ in
                //Cancel Action
                self.addToDownloadFlag = 1
                 self.addToDownloadProduct(productsId: downloadString, customerId: customerId)
            }))
            alert.addAction(UIAlertAction(title: CANCEL,
                                          style: UIAlertAction.Style.destructive,
                                          handler: {(_: UIAlertAction!) in
                                            //Sign out action
            }))
            self.present(alert, animated: true, completion: nil)
         
        }
       
    }
    
    @IBAction func btnSearch(_ sender: Any) {
        
        let search = self.storyboard?.instantiateViewController(withIdentifier: "SearchVC") as? SearchVC
        navigationController?.pushViewController(search!, animated: true)
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func openSortPopup() {
        let selectedValue = sort_by //update this for selected value
        //[("Men","Men"),("Women","Women"),("Both","Both")]
        
        let action = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for obj in self.sheetData {
            
//
//                if let selection = currentSelection, value == selection {
//                    // Note that checkmark and space have a neutral text flow direction so this is correct for RTL
//                    title = "✔︎ " + title
//                }
//
                action.addAction(
                    UIAlertAction(title: obj.label, style: .default) {_ in
                        //print(obj.value)
                        self.sort_by = obj.value!
                        
                        self.pageCount = 1
                        self.arrList.removeAll()
                        self.hasMoredata = false
                        self.gridList.reloadData()
                        if (UserDefaults.standard.string(forKey: USER_SESSION_DATA_KEY)) != nil {
                            self.getCategoryProduct(categoryId: self.id!, groupId: groupId, page: String(self.pageCount), price: "", gold_purity: "", diamond_quality: "", diamond_shape: "", sku: "", availability: "", sort_by: self.sort_by,showLoader: true)
                        }else{
                            self.getCategoryProduct(categoryId: self.id!, groupId: groupId, page: String(self.pageCount), price: "", gold_purity: "", diamond_quality: "", diamond_shape: "", sku: "", availability: "", sort_by: self.sort_by,showLoader: true)
                        }
                  
                        //action(obj.value)
                    }
                )
           
        }
//        let action = UIAlertController.actionSheetWithItems(items: arrData, currentSelection: selectedValue, action: { (value)  in
//           // self.lblGender.text = value
//        })
        action.addAction(UIAlertAction.init(title: "Cancel and Clear", style: UIAlertAction.Style.cancel){_ in
            self.sort_by = ""
        }
        )
        //Present the controller
        
        self.present(action, animated: true, completion: nil)
        
    }
    
    
}

extension UIAlertController {
    static func actionSheetWithItems<A : Equatable>(items : [(title : String, value : A)], currentSelection : A? = nil, action : @escaping (A) -> Void) -> UIAlertController {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for (var title, value) in items {
            if let selection = currentSelection, value == selection {
                // Note that checkmark and space have a neutral text flow direction so this is correct for RTL
                title = "✔︎ " + title
            }
            controller.addAction(
                UIAlertAction(title: title, style: .default) {_ in
                    action(value)
                }
            )
        }
        return controller
    }
    
}
    
    
extension ListVC{
    
    
    func updateDownloadFlag(){
        var i:Int = 0
        for _ in self.arrList{
            self.arrList[i].download_flag = 1
            i += 1
            
        }
        self.gridList.reloadData()
        self.addToDownloadFlag = 0
        
    }
    
    
    
    func getCategoryProduct(categoryId:String,groupId:String,page:String,price:String,gold_purity:String,diamond_quality:String,diamond_shape:String,sku:String,availability:String,sort_by:String,showLoader: Bool = false) {
        
        if showLoader {
            RESpinner.shared.show(view: self.view)

        }
        
        let par = ["customer_id": customerId,
                   "category_id": categoryId,
                   "group_id": groupId,
                   "page": page,
                   "price": price,
                   "gold_purity": gold_purity,
                   "diamond_quality": diamond_quality,
                   "diamond_shape": diamond_shape,
                   "sku": sku,
                   "availability": availability,
                   "sort_by":sort_by]
        
       
        
        ApiManager.shared.apiList(params:par as [String : AnyObject]) { (result) in
            
            
            
        RESpinner.shared.hide()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                self.reloadTable()
            } else {
                let data = Mapper<ListItem>().map(JSON: result)
            
                let listData = Mapper<ListItem.Data>().mapArray(JSONArray: result["data"] as! [[String : Any]])
                
                if listData.count < pagesize {
                    self.hasMoredata = false
                } else {
                    self.hasMoredata = true
                }
                
                if self.pageCount == 1 {
                    self.arrList.removeAll()
                    self.gridList.reloadData()
                    self.arrList = listData
                } else {
                    self.arrList.append(contentsOf: listData)
                }
                self.reloadTable()
                self.pageCount += 1
                
            }
            
        }

    }
    
    
    
    func getSortFilter(url:String) {
        
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        
        ApiManager.shared.apiGetSortFilter(url: url){ (result) in
      
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            
            self.getCategoryProduct(categoryId: self.id!, groupId: groupId, page: String(self.pageCount), price: "", gold_purity: "", diamond_quality: "", diamond_shape: "", sku: "", availability: "", sort_by: "",showLoader: true)
            
            if status == FAILURE_CODE || status == nil {
                self.btnsort.isEnabled = false
                self.btnfilter.isEnabled = false
            } else {
                 RappleActivityIndicatorView.stopAnimation()
                let sortfilterData=Mapper<SortFilterItem>().map(JSON: result)
                arrFilterData = (sortfilterData?.data)!
                
                self.sheetData = (sortfilterData?.sort_by)!
            }
            
        }
        
    }
    
    func addToDownloadProduct(productsId:String,customerId:String) {
        let par = ["product_ids": productsId,
                   "customer_id": customerId]
        
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiAddToDownload(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                if self.addToDownloadFlag == 1 {
                self.updateDownloadFlag()
                }
            }
            
        }
        
    }
    
    func reloadTable() {
        if self.arrList.count > 0 {
            self.viewNoData.isHidden = true
        } else {
            self.viewNoData.isHidden = false
        }
        self.gridList.reloadData()
    }
    
    
    @objc func refresh() {
        self.pageCount = 1
        self.hasMoredata = false
        self.arrList.removeAll()
        self.gridList.reloadData()
//        self.getData()
    }
    
    
    
    func searchProduct(searchTerm:String,page:String,showLoader: Bool = false)  {
        if showLoader {
            RESpinner.shared.show(view: self.view)
            
        }
        
        let par = ["search_term": searchTerm,
                   "page": page]
        
        
        
        ApiManager.shared.apiSearch(params:par as [String : AnyObject]) { (result) in
            
            
            
            RESpinner.shared.hide()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                self.reloadTable()
            } else {
                let data = Mapper<ListItem>().map(JSON: result)
                
                let listData = Mapper<ListItem.Data>().mapArray(JSONArray: result["data"] as! [[String : Any]])
                
                if listData.count < pagesize {
                    self.hasMoredata = false
                } else {
                    self.hasMoredata = true
                }
                
                if self.pageCount == 1 {
                    self.arrList.removeAll()
                    self.gridList.reloadData()
                    self.arrList = listData
                } else {
                    self.arrList.append(contentsOf: listData)
                }
                self.reloadTable()
                self.pageCount += 1
                
            }
            
        }
    }
    
    
}


extension ListVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.gridList.frame.width / 2) - 5, height: 210)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.hasMoredata ? self.arrList.count + 1 : self.arrList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if hasMoredata && indexPath.row == self.arrList.count {
            if id == "search"{
                let cell = self.gridList.dequeueReusableCell(withReuseIdentifier: "LoaderGridCell", for: indexPath) as? LoaderGridCell
                cell?.gridIndicator.startAnimating()
                // self.getData()
                self.searchProduct(searchTerm: headerTitle!, page: String(pageCount))
                
                
                return cell!
                
            }else{
            let cell = self.gridList.dequeueReusableCell(withReuseIdentifier: "LoaderGridCell", for: indexPath) as? LoaderGridCell
            cell?.gridIndicator.startAnimating()
           // self.getData()
            self.getCategoryProduct(categoryId: id!, groupId: groupId, page: String(pageCount), price: price, gold_purity: gold_purity, diamond_quality: diamond_quality, diamond_shape: diamond_shape, sku: sku, availability: availability, sort_by: sort_by)
            return cell!
            }
            
        }
        
        let cell = self.gridList.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as! ListCell
        
        cell.listData = self.arrList[indexPath.row]
        
        cell.actionBlockDownload = {
            self.arrList[indexPath.row].download_flag = 1
            self.gridList.reloadItems(at: [indexPath])
            self.addToDownloadProduct(productsId: self.arrList[indexPath.row].entity_id!, customerId: customerId)
            
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        let productDetail = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailVC") as? ProductDetailVC
        productDetail?.productId=self.arrList[indexPath.row].entity_id!
        self.navigationController?.pushViewController(productDetail!, animated: true)
        
        
//        self.arrEvents[indexPath.row].is_viewed=true
//        self.gridEvent.reloadItems(at: [indexPath])
        
//        let event = self.storyboard?.instantiateViewController(withIdentifier: "EventDetailVC") as? EventDetailVC
        //        event?.eventDetail = self.arrEvents[indexPath.row]
//        event?.eventId = self.arrEvents[indexPath.row].iD!
//        self.navigationController?.pushViewController(event!, animated: true)
        
    }
    
}
