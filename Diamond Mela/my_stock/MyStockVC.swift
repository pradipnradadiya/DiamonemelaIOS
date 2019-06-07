import UIKit
import ObjectMapper
import RappleProgressHUD

class MyStockVC: UIViewController {

    var pageCount: Int = 1
    var arrList = [MyStockItem.Data]()
    let refreshControl = UIRefreshControl()
    var hasMoredata: Bool = false
        
    @IBOutlet weak var gridMyStock: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getMyStockProducts(group_id: groupId, pagesize: String(pageCount), price: "", gold_purity: "", diamonod_quality: "", diamond_shape: "", sku: "", availability: "", sort_by: "")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnFilter(_ sender: Any) {
        
    }
    
}

extension MyStockVC{
    
    func getMyStockProducts(group_id:String,pagesize:String,price:String,gold_purity:String,diamonod_quality:String,diamond_shape:String,sku:String,availability:String,sort_by:String)  {
        
        let par = ["customer_id": customerId,
                   "group_id": group_id,
                   "pagesize": pagesize,
                   "price": price,
                   "gold_purity": gold_purity,
                   "diamonod_quality": diamonod_quality,
                   "diamond_shape": diamond_shape,
                   "sku": sku,
                   "availability": availability,
                   "sort_by":sort_by]
        
        
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiMyStockList(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
              //  let data = Mapper<MyStockItem>().map(JSON: result)
                
                let listData = Mapper<MyStockItem.Data>().mapArray(JSONArray: result["data"] as! [[String : Any]])
                
                if listData.count < 10 {
                    self.hasMoredata = false
                } else {
                    self.hasMoredata = true
                }
                
                if self.pageCount == 1 {
                    self.arrList.removeAll()
                    self.gridMyStock.reloadData()
                    self.arrList = listData
                } else {
                    self.arrList.append(contentsOf: listData)
                }
                self.reloadTable()
                self.pageCount += 1
                
            }
            
        }
    }
    
    func saleProduct(product:String){
        let par = ["product":product,"customer_id": customerId]
        
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiMyStockSaleOrder(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                let msg = result["message"] as? String
                self.showAlert(title: SUCCESS, message: msg!)
                
            }
            
        }
        
    }
    
    func reloadTable() {
        
    }
    
}


extension MyStockVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.gridMyStock.frame.width / 2) - 5, height: 210)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.hasMoredata ? self.arrList.count + 1 : self.arrList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if hasMoredata && indexPath.row == self.arrList.count {
            let cell = self.gridMyStock.dequeueReusableCell(withReuseIdentifier: "LoaderGridCell", for: indexPath) as? LoaderGridCell
            cell?.gridIndicator.startAnimating()
            
            self.getMyStockProducts(group_id: groupId, pagesize: String(pageCount), price: "", gold_purity: "", diamonod_quality: "", diamond_shape: "", sku: "", availability: "", sort_by: "")
            
            return cell!
        }
        
        let cell = self.gridMyStock.dequeueReusableCell(withReuseIdentifier: "MyStockCell", for: indexPath) as! MyStockCell
        
        cell.myStockData = self.arrList[indexPath.row]
        
        cell.actionBlockSaleProduct = {
            
            self.saleProduct(product: self.arrList[indexPath.row].product_id!)
            
        }
       
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

