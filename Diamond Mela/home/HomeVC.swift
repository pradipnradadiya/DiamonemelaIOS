
import UIKit
import ObjectMapper
import RappleProgressHUD
import FSPagerView

class HomeVC: UIViewController,FSPagerViewDataSource,FSPagerViewDelegate {

    @IBOutlet weak var lblCartCount: UILabelX!
    
    @IBOutlet weak var pagerView: FSPagerView!{
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.typeIndex = 4
        }
    }
    
    @IBOutlet weak var btnCaClick: UIButton!
    //  fileprivate let imageNames = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg"]
    fileprivate let transformerNames = ["cross fading", "zoom out", "depth", "linear", "overlap", "ferris wheel", "inverted ferris wheel", "coverflow", "cubic"]
    
    
    fileprivate let transformerTypes: [FSPagerViewTransformerType] = [.crossFading,
                                                                      .zoomOut,
                                                                      .depth,
                                                                      .linear,
                                                                      .overlap,
                                                                      .ferrisWheel,
                                                                      .invertedFerrisWheel,
                                                                      .coverFlow,
                                                                      .cubic]
    fileprivate var typeIndex = 0 {
        didSet {
            let type = self.transformerTypes[typeIndex]
            self.pagerView.transformer = FSPagerViewTransformer(type:type)
            switch type {
            case .crossFading, .zoomOut, .depth:
                self.pagerView.itemSize = FSPagerView.automaticSize
                self.pagerView.decelerationDistance = 1
            case .linear, .overlap:
                let transform = CGAffineTransform(scaleX: 0.4, y: 1)
                self.pagerView.itemSize = self.pagerView.frame.size.applying(transform)
                self.pagerView.decelerationDistance = FSPagerView.automaticDistance
            case .ferrisWheel, .invertedFerrisWheel:
                self.pagerView.itemSize = CGSize(width: 180, height: 140)
                self.pagerView.decelerationDistance = FSPagerView.automaticDistance
            case .coverFlow:
                self.pagerView.itemSize = CGSize(width: 220, height: 170)
                self.pagerView.decelerationDistance = FSPagerView.automaticDistance
            case .cubic:
                let transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                self.pagerView.itemSize = self.pagerView.frame.size.applying(transform)
                self.pagerView.decelerationDistance = 1
            }
        }
    }
    
    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var gridMostSellingProduct: UICollectionView!
    @IBOutlet weak var gridBestCategory: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var gridBanner: UICollectionView!
    @IBOutlet weak var gridHeader: UICollectionView!
    @IBOutlet weak var btnPeople: UIButton!
    @IBOutlet weak var btnUser: UIButton!
    @IBOutlet weak var btnCompare: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    var arrHeader = [HeaderItem.Data]()
    var arrBanner = [BannerItem.Slider_image]()
    var arrMostSellingProducts = [MostSellingProductItem.Data]()
    var arrPopularProducts = [PopularProductItem.Product_img]()
    
    //slide menu
    var menu_vc : DrawerVC!
    
    var count:Int = 3
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        FilterVC.dict.removeAll()
        FilterVC.filterFlag = 0
        
        arrFilterData.removeAll()
        
        self.getCartCount()
        
        
    }
    
    @IBAction func btnCarClick(_ sender: Any) {
        if let dataArrayString = (UserDefaults.standard.string(forKey: USER_SESSION_DATA_KEY)) {
            let cart = self.storyboard?.instantiateViewController(withIdentifier: "CartVC") as? CartVC
            self.navigationController?.pushViewController(cart!, animated: true)
        }
            
        else{
            
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func btnViewAll(_ sender: Any) {
        
        let popProduct = self.storyboard?.instantiateViewController(withIdentifier: "PopularProductVC") as? PopularProductVC
        self.navigationController?.pushViewController(popProduct!, animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dataArrayString = (UserDefaults.standard.string(forKey: USER_SESSION_DATA_KEY)) {
            
            if let dataObject = Mapper<LoginItem>().map(JSONString: dataArrayString)  {
                customerId=dataObject.data?.entity_id! ?? ""
                groupId=dataObject.data?.group_id ?? ""
                print(customerId)
                
            }
        }
        
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        
        self.getBannerSlider(url: Endpoint.bannerSlider.url)
        self.getHeaderMenuBestCategory(url: Endpoint.headerMenu.url)
        self.getMostSellingProduct(url: Endpoint.mostSellingProducts.url)
      //  self.getPopularProduct(url: Endpoint.popularProducts.url)
        
        
        //using slide drawer
        menu_vc=self.storyboard?.instantiateViewController(withIdentifier: "DrawerVC") as? DrawerVC
        
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
       
        
       //  let tapView = UITapGestureRecognizer(target: self, action: #selector(self.respondToTapGesture))
      //  self.view.addGestureRecognizer(tapView)
        // Do any additional setup after loading the view.
    }

    @IBAction func btnSearch(_ sender: Any) {
        let search = self.storyboard?.instantiateViewController(withIdentifier: "SearchVC") as? SearchVC
        navigationController?.pushViewController(search!, animated: true)
        
    }
    @IBAction func btnPeople(_ sender: Any) {
    }
    @IBAction func btnUser(_ sender: Any) {
    }
    @IBAction func btnCompare(_ sender: Any) {
    }
    @IBAction func btnHome(_ sender: Any) {
    }
    @IBAction func btnMenu(_ sender: Any) {
        if AppDelegate.menu_bool{
            //show thw menu
            showMenu()
        }
        else{
            //close menu
            closeMenu()
        }
    }
    @objc func respondToGesture(gesture : UISwipeGestureRecognizer){
        switch gesture.direction {
        case UISwipeGestureRecognizer.Direction.left:
            //            print("left swipe")
            closeMenu()
        default:
            print("default")
        }
    }
    
    func showMenu() {
        
        UIView.animate(withDuration: 0.1) {()->Void in
            
            self.menu_vc.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.menu_vc.view.backgroundColor=UIColor.black.withAlphaComponent(0.6)
            self.addChild(self.menu_vc)
            self.view.addSubview(self.menu_vc.view)
            AppDelegate.menu_bool = false
            
        }
        
    }
    
    func closeMenu() {
        UIView.animate(withDuration: 0.3, animations: {()->Void in
            
            self.menu_vc.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        }){(finished) in
            self.menu_vc.view.removeFromSuperview()
        }
        AppDelegate.menu_bool = true
        
    }
    
    @IBAction func btnEditProfile(_ sender: Any) {
        let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as? EditProfileVC
        self.navigationController?.pushViewController(editProfile!, animated: true)
        
//        let editProfile = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController
//        self.navigationController?.pushViewController(editProfile!, animated: true)
    
        
    }
    @IBAction func btnOrder(_ sender: Any) {
        let orderTab = self.storyboard?.instantiateViewController(withIdentifier: "OrderTabVC") as? OrderTabVC
        self.navigationController?.pushViewController(orderTab!, animated: true)
    }
    @IBAction func btnTransaction(_ sender: Any) {
        let transaction = self.storyboard?.instantiateViewController(withIdentifier: "TransactionVC") as? TransactionVC
        self.navigationController?.pushViewController(transaction!, animated: true)
    }
    
    
    
    // MARK:- FSPagerViewDataSource
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return arrPopularProducts.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
      //  cell.imageView?.backgroundColor = UIColor.black
        cell.imageView?.sd_setImage(with: URL(string: "\(IMAGE_URL)catalog/product\(arrPopularProducts[index].thumbnail!)"), placeholderImage: UIImage(named: "Diamond-mela-mobile-logo.png"))
//        cell.imageView?.image = UIImage(named: self.imageNames[index])
        
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        return cell
        
    }
    
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        print("click")
        
        let list = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailVC") as? ProductDetailVC
        list?.productId = self.arrPopularProducts[index].entity_id!
        self.navigationController?.pushViewController(list!, animated: true)
        
    }
    
    
    
    
    
}

extension HomeVC{
    
    func getCartCount() {
        
        if (UserDefaults.standard.string(forKey: USER_SESSION_DATA_KEY)) != nil {
      
        
        let par = ["customer_id": customerId]
        
        //        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiGetDownloadCartCount(params:par as [String : AnyObject]) { (result) in
            
            //            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                let total_qty = result["total_qty"] as? Int
                let download_count = result["download_count"] as? Int
                
                
                //Cart count
                if total_qty != 0{
                    self.lblCartCount.isHidden = false
                    self.lblCartCount.text = "\(total_qty ?? 0)"
                    
                }else{
                    self.lblCartCount.isHidden = true
                }
                
                
                //Download count
                if download_count != 0{
                    
                }else{
                    
                }
                
            }
            
        }
    }
        
        else{
            //cart array dictionry
            var arrayOfDict = [[String: String]]()
            if (UserDefaults.standard.array(forKey: CART_USERDEFAULTS)) != nil {
                arrayOfDict = userSessionData.value(forKey: CART_USERDEFAULTS) as! [[String : String]]
                
                if arrayOfDict.isEmpty{
                    self.lblCartCount.isHidden = true
                }else{
                    self.lblCartCount.isHidden = false
                    self.lblCartCount.text = String(arrayOfDict.count)
                }
                
            }
        }
        
        
        
    }
    
    
    
    
    func getPopularProduct(url:String){
//        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiPopularProduct(url: url){ (result) in
            self.count -= 1
            if self.count == 0{
                RappleActivityIndicatorView.stopAnimation()
            }
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                let data=Mapper<PopularProductItem>().map(JSON: result)
                self.arrPopularProducts = (data?.product_img)!
                
                print(self.arrPopularProducts.count)
                
                self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
                self.typeIndex = 4
            }
            
        }
    }
    
    func getMostSellingProduct(url:String){
//        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiMostSellingProduct(url: url){ (result) in
            self.count -= 1
            if self.count == 0{
                RappleActivityIndicatorView.stopAnimation()
            }
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
//                let data=Mapper<MostSellingProductItem>().map(JSON: result)
                self.arrMostSellingProducts=Mapper<MostSellingProductItem.Data>().mapArray(JSONArray: result["data"] as! [[String : Any]])
                self.reloadMostSellingTable()
            }
            
        }
    }
    
    func getHeaderMenuBestCategory (url:String){
//        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiHeaderBestCategory(url: url){ (result) in
            self.count -= 1
            if self.count == 0{
                RappleActivityIndicatorView.stopAnimation()
            }
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                
             //   let data=Mapper<HeaderItem>().map(JSON: result)
                self.arrHeader=Mapper<HeaderItem.Data>().mapArray(JSONArray: result["data"] as! [[String : Any]])
                self.reloadTable()
                self.reloadTableBestCategory()
                
            }
            
        }
    }
    
    func reloadMostSellingTable() {
        if self.arrMostSellingProducts.count > 0 {
            //            self.lblNoData.isHidden = true
        } else {
            //            self.lblNoData.isHidden = false
        }
        self.gridMostSellingProduct.reloadData()
    }
    
    func reloadTable() {
        if self.arrHeader.count > 0 {
            //            self.lblNoData.isHidden = true
        } else {
            //            self.lblNoData.isHidden = false
        }
        self.gridHeader.reloadData()
    }
    
    func reloadTableBanner() {
        if self.arrBanner.count > 0 {
            //            self.lblNoData.isHidden = true
        } else {
            //            self.lblNoData.isHidden = false
        }
        self.gridBanner.reloadData()
    }
    
    func reloadTableBestCategory() {
        if self.arrHeader.count > 0 {
            //            self.lblNoData.isHidden = true
        } else {
            //            self.lblNoData.isHidden = false
        }
        self.gridBestCategory.reloadData()
    }
    
    
    
    func getBannerSlider(url:String){
//        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiBannerSlider(url: url){ (result) in
            
            self.count -= 1
            if self.count == 0{
                RappleActivityIndicatorView.stopAnimation()
            }
            
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                let bannerdata=Mapper<BannerItem>().map(JSON: result)
                
                self.imgBanner.sd_setImage(with: URL(string: "\(bannerdata?.banner_image! ?? "")"), placeholderImage: UIImage(named: "Diamond-mela-mobile-logo.png"))
                
                
                
                self.arrBanner=Mapper<BannerItem.Slider_image>().mapArray(JSONArray: result["slider_image"] as! [[String : Any]])
                self.reloadTableBanner()
                
            }
            
        }
    }
    
}


extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.gridBestCategory {
            return CGSize(width: gridBestCategory.frame.width / 2 - 5, height: 224)
            
        }else if collectionView == self.gridHeader {
             return CGSize(width: 67, height: 82)
        }
        else if collectionView == self.gridMostSellingProduct{
            return CGSize(width: 174, height: 220)
        }
        else {
            return CGSize(width: self.gridBanner.frame.width, height: 224)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.gridHeader {
            return self.arrHeader.count
        }
            
        else if collectionView == self.gridBestCategory{
            return self.arrHeader.count
        }
        else if collectionView == self.gridMostSellingProduct{
            return self.arrMostSellingProducts.count
        }
        
        else {
            self.pageControl.numberOfPages=self.arrBanner.count
            return self.arrBanner.count
            
        }
        
//        return self.arrHeader.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.gridHeader {
            let cell = self.gridHeader.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            
            cell.headerData = self.arrHeader[indexPath.row]
            return cell
        }
        else if collectionView == self.gridBestCategory{
            let cell = self.gridBestCategory.dequeueReusableCell(withReuseIdentifier: "BestCategoryCell", for: indexPath) as! BestCategoryCell
            cell.bestCategoryData = self.arrHeader[indexPath.row]
            return cell
        }
             else if collectionView == self.gridMostSellingProduct{
            let cell = self.gridMostSellingProduct.dequeueReusableCell(withReuseIdentifier: "MostSellingCell", for: indexPath) as! MostSellingCell
            cell.mostSellingData = self.arrMostSellingProducts[indexPath.row]
            return cell
            
            
        }
            
        else{
            let cell = self.gridBanner.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
            cell.bannerData = self.arrBanner[indexPath.row]
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == self.gridHeader {
        }
        else if collectionView == self.gridBestCategory {
            
        }
        else if collectionView == self.gridMostSellingProduct {
            
        }
        else{
            self.pageControl.currentPage = indexPath.row
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //        self.arrEvents[indexPath.row].is_viewed=true
        //        self.gridEvent.reloadItems(at: [indexPath])
        
        if collectionView == self.gridHeader {
                let list = self.storyboard?.instantiateViewController(withIdentifier: "ListVC") as? ListVC
                list?.headerTitle = self.arrHeader[indexPath.row].name
                list?.id = self.arrHeader[indexPath.row].entity_id
                self.navigationController?.pushViewController(list!, animated: true)
        }
            
        else if collectionView == self.gridBestCategory {
            let list = self.storyboard?.instantiateViewController(withIdentifier: "ListVC") as? ListVC
            list?.headerTitle = self.arrHeader[indexPath.row].name
            list?.id = self.arrHeader[indexPath.row].entity_id
            self.navigationController?.pushViewController(list!, animated: true)
        }
            
        else if collectionView == self.gridMostSellingProduct {
            let list = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailVC") as? ProductDetailVC
            list?.productId = self.arrMostSellingProducts[indexPath.row].entity_id!
            self.navigationController?.pushViewController(list!, animated: true)
        }
            
        else{
            
        }
        
    }
    
}

