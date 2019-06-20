import UIKit
import ObjectMapper
import RappleProgressHUD

class SearchVC: UIViewController {

    @IBOutlet weak var gridHeader: UICollectionView!
    @IBOutlet weak var tvSearch: UITextField!
     var arrHeader = [HeaderItem.Data]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getHeaderMenuBestCategory(url: Endpoint.headerMenu.url)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSearch(_ sender: Any) {
        let list = self.storyboard?.instantiateViewController(withIdentifier: "ListVC") as? ListVC
        list?.headerTitle = tvSearch.text!
        list?.id = "search"
        self.navigationController?.pushViewController(list!, animated: true)
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension SearchVC{
    
    func getHeaderMenuBestCategory (url:String){
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiHeaderBestCategory(url: url){ (result) in
           
           
            RappleActivityIndicatorView.stopAnimation()
          
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                
                //   let data=Mapper<HeaderItem>().map(JSON: result)
                self.arrHeader=Mapper<HeaderItem.Data>().mapArray(JSONArray: result["data"] as! [[String : Any]])
                self.reloadTable()
              
            }
            
        }
    }
    
    func reloadTable() {
        if self.arrHeader.count > 0 {
            //            self.lblNoData.isHidden = true
        } else {
            //            self.lblNoData.isHidden = false
        }
        self.gridHeader.reloadData()
    }
    
}

extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: 67, height: 82)
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
            return self.arrHeader.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
            let cell = self.gridHeader.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            
            cell.headerData = self.arrHeader[indexPath.row]
            return cell
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //        self.arrEvents[indexPath.row].is_viewed=true
        //        self.gridEvent.reloadItems(at: [indexPath])
        
            let list = self.storyboard?.instantiateViewController(withIdentifier: "ListVC") as? ListVC
            list?.headerTitle = self.arrHeader[indexPath.row].name
            list?.id = self.arrHeader[indexPath.row].entity_id
            self.navigationController?.pushViewController(list!, animated: true)
       
    }
    
}


