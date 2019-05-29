import UIKit
import ObjectMapper
import RappleProgressHUD

class ListVC: UIViewController {

    var pageCount: Int = 1
    var arrList = [ListItem.Data]()
    let refreshControl = UIRefreshControl()
    var hasMoredata: Bool = false
    var headerTitle: String?=""
    var id:String?=""
    
    @IBOutlet weak var gridList: UICollectionView!
    @IBOutlet weak var btnfilter: UIButtonX!
    @IBOutlet weak var btnsort: UIButtonX!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCategoryProduct(categoryId: id!, groupId: groupId, page: String(pageCount), price: "", gold_purity: "", diamond_quality: "", diamond_shape: "", sku: "", availability: "", sort_by: "")
        // Do any additional setup after loading the view.
        
        self.navigationItem.title=headerTitle
        
        self.getSortFilter(url: Endpoint.getSortFilter.url)
    }
    
    @IBAction func btnCart(_ sender: Any) {
    }
    
    @IBAction func btnFilter(_ sender: Any) {
    }
    
    @IBAction func btnSortBy(_ sender: Any) {
        self.openSortPopup()
    }
    
    @IBAction func btnSearch(_ sender: Any) {
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func openSortPopup() {
        let selectedValue = "Men" //update this for selected value
        let action = UIAlertController.actionSheetWithItems(items: [("Men","Men"),("Women","Women"),("Both","Both")], currentSelection: selectedValue, action: { (value)  in
           // self.lblGender.text = value
        })
        action.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
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
    func getCategoryProduct(categoryId:String,groupId:String,page:String,price:String,gold_purity:String,diamond_quality:String,diamond_shape:String,sku:String,availability:String,sort_by:String) {
        
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
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiList(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
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
            RappleActivityIndicatorView.stopAnimation()
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                let data=Mapper<SortFilterItem>().map(JSON: result)
                
             
                
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
                let data = Mapper<SortFilterItem>().map(JSON: result)
            }
            
        }
        
    }
    
    func reloadTable() {
        if self.arrList.count > 0 {
//            self.lblNoData.isHidden = true
        } else {
//            self.lblNoData.isHidden = false
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
            let cell = self.gridList.dequeueReusableCell(withReuseIdentifier: "LoaderGridCell", for: indexPath) as? LoaderGridCell
            cell?.gridIndicator.startAnimating()
           // self.getData()
             self.getCategoryProduct(categoryId: "6", groupId: "6", page: String(pageCount), price: "", gold_purity: "", diamond_quality: "", diamond_shape: "", sku: "", availability: "", sort_by: "")
            return cell!
        }
        
        let cell = self.gridList.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as! ListCell
        
        cell.listData = self.arrList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        self.arrEvents[indexPath.row].is_viewed=true
//        self.gridEvent.reloadItems(at: [indexPath])
        
//        let event = self.storyboard?.instantiateViewController(withIdentifier: "EventDetailVC") as? EventDetailVC
        //        event?.eventDetail = self.arrEvents[indexPath.row]
//        event?.eventId = self.arrEvents[indexPath.row].iD!
//        self.navigationController?.pushViewController(event!, animated: true)
        
    }
    
}
