import UIKit
import ObjectMapper
import RappleProgressHUD

class ProductDetailVC: UIViewController {

    var productId:String = ""
    var productCategoryId:String = ""
    
    var sliderImage: [String] = []
    var arrRTS = [ProductDetailItem.Rts_slider]()
    var arrRing = [ProductDetailItem.Ringsize]()
    var arrDiamond = [ProductDetailItem.Stone_clarity]()
    var arrCarat: [String] = []
    var arrMetal : [String] = []
    
    
    @IBOutlet weak var btnSoldOut: UIButton!
    @IBOutlet weak var btnBuyNow: UIButton!
    @IBOutlet weak var btnAddToCart: UIButton!
    @IBOutlet weak var lblMetalEstimatedTotal: UILabel!
    @IBOutlet weak var lblMetalWeight: UILabel!
    @IBOutlet weak var lblMetalPurity: UILabel!
    @IBOutlet weak var tblDiamondDetail: UITableView!
    @IBOutlet weak var lblProductCertificateNo: UILabel!
    @IBOutlet weak var lblProductSku: UILabel!
    @IBOutlet weak var lblGrandTotal: UILabel!
    @IBOutlet weak var lblCountDiamond: UILabel!
    @IBOutlet weak var lblDiamondPrice: UILabel!
    @IBOutlet weak var lblMetalPrice: UILabel!
    @IBOutlet weak var gridMetal: UICollectionView!
    @IBOutlet weak var gridCarat: UICollectionView!
    @IBOutlet weak var gridDiamond: UICollectionView!
    @IBOutlet weak var gridRingSize: UICollectionView!
    @IBOutlet weak var gridRtsSlider: UICollectionView!
    @IBOutlet weak var lblMetalType: UILabel!
    @IBOutlet weak var lblFinalPrice: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var gridSlider: UICollectionView!
    @IBOutlet weak var gridPager: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getProductDetail(productId: productId, metalCarat: "14K", metalQualityColor: "Yellow Gold", ringSize: "", stoneQuality: "", bangleProId: "", braceletProId: "", pendentProId: "")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBuynow(_ sender: Any) {
    }
    @IBAction func btnAddtoCart(_ sender: Any) {
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCart(_ sender: Any) {
    }
    @IBAction func btnSearch(_ sender: Any) {
    }
}

extension ProductDetailVC{
    
    func getProductDetail(productId:String,metalCarat:String,metalQualityColor:String,ringSize:String,stoneQuality:String,bangleProId:String,braceletProId:String,pendentProId:String,showLoader: Bool = false) {
        
        if showLoader {
            RESpinner.shared.show(view: self.view)
        }
        
        let par = ["product_id": productId,
                   "metalcarat": metalCarat,
                   "metalqualitycolor": metalQualityColor,
                   "ringsize": ringSize,
                   "stone_quality": ringSize,
                   "bangle_pro_id": bangleProId,
                   "bracelet_pro_id": braceletProId,
                   "pendent_pro_id": pendentProId]
        
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiGetProductDetail(params:par as [String : AnyObject]) { (result) in
            RESpinner.shared.hide()
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
                
            } else {
                
                let productDetailData=Mapper<ProductDetailItem>().map(JSON: result)
                self.productCategoryId=(productDetailData?.category_id!)!
                self.sliderImage = (productDetailData?.slider)!
                self.arrRTS = (productDetailData?.rts_slider)!
                self.arrRing = (productDetailData?.ringsize)!
                self.arrDiamond = (productDetailData?.stone_clarity)!
                self.arrCarat = (productDetailData?.carat)!
                self.arrMetal = (productDetailData?.metal)!
                
                self.gridPager.reloadData()
                self.gridSlider.reloadData()
                self.gridRtsSlider.reloadData()
                self.gridRingSize.reloadData()
                self.gridDiamond.reloadData()
                self.gridCarat.reloadData()
                self.gridMetal.reloadData()
                
                
                if productDetailData?.stock == "0"{
                    self.btnAddToCart.isHidden=true
                    self.btnBuyNow.isHidden=true
                    self.btnSoldOut.isHidden=false
                }else{
                    self.btnAddToCart.isHidden=false
                    self.btnBuyNow.isHidden=false
                    self.btnSoldOut.isHidden=true
                }
                
                if self.productCategoryId == RING_ID{
                    
                }else if self.productCategoryId == BRACELETS_ID{
                    
                }else if self.productCategoryId == BANGLE_ID{
                    
                }else if self.productCategoryId == PENDANTS_SETS_ID{
                    
                }else{
                    
                }
                
                
                
                //using for Image slider
                
                if productDetailData?.products == "simple"{
                    
                }else{
                    
                }
                
                
                //product detail
                self.lblProductName.text=productDetailData?.product_details?[0].product_name
             
                self.lblProductSku.text=productDetailData?.product_details?[0].sku
                
                self.lblProductCertificateNo.text=productDetailData?.product_details?[0].certificate_no
              
                self.lblGrandTotal.text=productDetailData?.product_details?[0].price
                
                //metal detail
                self.lblMetalPurity.text=productDetailData?.metaldetails?[0].metalquality
                
                self.lblMetalWeight.text=productDetailData?.metaldetails?[0].metalweight
              
                self.lblMetalEstimatedTotal.text="\(productDetailData?.metaldetails?[0].metalestimatedprice ?? 0)"
               
                
                //metal and diamone piece and price
                self.lblMetalPrice.text="\(productDetailData?.metalprice ?? [0])"
               
                self.lblCountDiamond.text="Diamond(\(productDetailData?.diamondmainprice?[0].pices ?? ""))"
                
                self.lblDiamondPrice.text=productDetailData?.diamondmainprice?[0].dimondprice
                self.lblFinalPrice.text=productDetailData?.product_details?[0].price
            
                
            }
            
        }
        
    }
    
    
    func getProductDetailRefresh(productId:String,metalCarat:String,metalQualityColor:String,ringSize:String,stoneQuality:String,bangleProId:String,braceletProId:String,pendentProId:String,clickAction:String) {
        
        
        let par = ["product_id": productId,
                   "metalcarat": metalCarat,
                   "metalqualitycolor": metalQualityColor,
                   "ringsize": ringSize,
                   "stone_quality": ringSize,
                   "bangle_pro_id": bangleProId,
                   "bracelet_pro_id": braceletProId,
                   "pendent_pro_id": pendentProId]
        
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiGetProductDetail(params:par as [String : AnyObject]) { (result) in
           
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
                
            } else {
                let productDetail=Mapper<ProductDetailItem>().map(JSON: result)
                self.sliderImage = (productDetail?.slider)!
                self.arrRTS = (productDetail?.rts_slider)!
                self.arrRing = (productDetail?.ringsize)!
                self.arrDiamond = (productDetail?.stone_clarity)!
                self.arrCarat = (productDetail?.carat)!
                self.arrMetal = (productDetail?.metal)!
                
                
                self.gridPager.reloadData()
                self.gridSlider.reloadData()
                self.gridRtsSlider.reloadData()
                self.gridRtsSlider.reloadData()
                self.gridRingSize.reloadData()
                self.gridDiamond.reloadData()
                self.gridCarat.reloadData()
                self.gridMetal.reloadData()
            }
            
        }
    }
    
    func addToCart(productId:String,customerId:String,optionId:String,optionTypeId:String,stoneOptionId:String,stoneOptionTypeId:String,qty:String){
      
        let par = ["product_id": productId,
                   "customer_id": customerId,
                   "option_id": optionId,
                   "option_type_id": optionTypeId,
                   "stone_option_id": stoneOptionId,
                   "stone_option_type_id": stoneOptionTypeId,
                   "qty": qty]
        
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiAddToCart(params:par as [String : AnyObject]) { (result) in
           
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
                
            } else {
                
                
            }
            
        }
        
        
    }
    
    func rtsProductClick(productId:String)  {
        
        let par = ["productId": productId]
        
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiRtsProductClick(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                let rtsDetail=Mapper<RTSItem>().map(JSON: result)
                
            } else {
                
                
            }
            
        }
    }
    
}


extension ProductDetailVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        if collectionView == self.gridHeader {
    //            return CGSize(width: gridHeader.frame.width / 3, height: gridHeader.frame.height)
    //        }else{
    //            return CGSize(width: gridBanner.frame.width, height: gridBanner.frame.height)
    //        }
    //
    //    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView==self.gridPager{
            return self.sliderImage.count
        }
        
        else if collectionView==self.gridRtsSlider{
            return self.arrRTS.count
        }
            
        else if collectionView==self.gridRingSize{
            return self.arrRing.count
        }
            
        else if collectionView==self.gridDiamond{
            return self.arrDiamond.count
        }
            
        else if collectionView==self.gridCarat{
            return self.arrCarat.count
        }
            
        else if collectionView==self.gridMetal{
            return self.arrMetal.count
        }
            
        else{
            return self.sliderImage.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView==self.gridPager{
            let cell = self.gridPager.dequeueReusableCell(withReuseIdentifier: "SliderPagerCell", for: indexPath) as! SliderPagerCell
            cell.slider = [self.sliderImage[indexPath.row]]
            cell.count=indexPath.row
            return cell
        }
            
        else if collectionView==self.gridRtsSlider{
            let cell = self.gridRtsSlider.dequeueReusableCell(withReuseIdentifier: "RTSCell", for: indexPath) as! RTSCell
            cell.rtsData = self.arrRTS[indexPath.row]
            cell.categoryId = productCategoryId
            return cell
        }
            
        else if collectionView==self.gridRingSize{
            let cell = self.gridRingSize.dequeueReusableCell(withReuseIdentifier: "RingCell", for: indexPath) as! RingCell
            cell.ringSize = self.arrRing[indexPath.row]
            return cell
        }
            
        else if collectionView==self.gridDiamond{
            let cell = self.gridDiamond.dequeueReusableCell(withReuseIdentifier: "DiamondCell", for: indexPath) as! DiamondCell
            cell.diamondData = self.arrDiamond[indexPath.row]
            return cell
        }
            
        else if collectionView==self.gridCarat{
            let cell = self.gridCarat.dequeueReusableCell(withReuseIdentifier: "CaratCell", for: indexPath) as! CaratCell
            cell.caratData = [self.arrCarat[indexPath.row]]
            cell.count = indexPath.row
            return cell
        }
            
        else if collectionView==self.gridMetal{
            let cell = self.gridMetal.dequeueReusableCell(withReuseIdentifier: "MetalCell", for: indexPath) as! MetalCell
            cell.metalData = [self.arrMetal[indexPath.row]]
            cell.count = indexPath.row
            return cell
        }
            
        else{
            let cell = self.gridSlider.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as! SliderCell
            cell.slider = [self.sliderImage[indexPath.row]]
            cell.count=indexPath.row
            return cell
        }
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        
    }
    
}

