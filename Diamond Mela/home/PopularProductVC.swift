import UIKit
import ObjectMapper
import RappleProgressHUD

class PopularProductVC: UIViewController {

    @IBOutlet weak var gridPopularProduct: UICollectionView!
    
    var arrPopularProduct = [PopularProductItem.Product_img]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getPopularProduct(url: Endpoint.popularProducts.url)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension PopularProductVC {
    func getPopularProduct(url:String){
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiPopularProduct(url: url){ (result) in
            RappleActivityIndicatorView.stopAnimation()
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                //let data=Mapper<PopularProductItem>().map(JSON: result)
                self.arrPopularProduct=Mapper<PopularProductItem.Product_img>().mapArray(JSONArray: result["product_img"] as! [[String : Any]])
                
                self.reloadTable()
                
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
                
                
            }
            
        }
        
    }
    
    func reloadTable() {
        
        if self.arrPopularProduct.count > 0 {
            //            self.lblNoData.isHidden = true
        } else {
            //            self.lblNoData.isHidden = false
        }
        self.gridPopularProduct.reloadData()
        
    }
    
}

extension PopularProductVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.gridPopularProduct.frame.width / 2) - 5, height: 210)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrPopularProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = self.gridPopularProduct.dequeueReusableCell(withReuseIdentifier: "PopularProductCell", for: indexPath) as! PopularProductCell
        
        cell.popularProduct = self.arrPopularProduct[indexPath.row]
        
        cell.actionBlockDownload = {
            
            self.arrPopularProduct[indexPath.row].download_flag = 1
            self.gridPopularProduct.reloadItems(at: [indexPath])
            self.addToDownloadProduct(productsId: self.arrPopularProduct[indexPath.row].entity_id!, customerId: customerId)
            
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
