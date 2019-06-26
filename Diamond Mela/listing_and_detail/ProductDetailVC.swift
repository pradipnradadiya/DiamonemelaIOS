import UIKit
import ObjectMapper
import RappleProgressHUD

class ProductDetailVC: UIViewController {

    var viewHeight:Int = 2400
    
    @IBOutlet weak var constraintDiamondTop: NSLayoutConstraint!
    @IBOutlet weak var viewAboveDiamond: UIView!
    @IBOutlet weak var constraintGemstoneHeight: NSLayoutConstraint!
    @IBOutlet weak var viewGemstone: UIView!
    @IBOutlet weak var constraintDiamondDetailTableHeight: NSLayoutConstraint!
    @IBOutlet weak var constraintMainHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var constraintCustomJewelaryHeight: NSLayoutConstraint!
    
    @IBOutlet weak var constraintBraceletsHeight: NSLayoutConstraint!
    
    @IBOutlet weak var constraintPendentHeight: NSLayoutConstraint!
    
    @IBOutlet weak var constraintRingHeight: NSLayoutConstraint!
    
    @IBOutlet weak var constraintBottonRingHeight: NSLayoutConstraint!
    
    @IBOutlet weak var constraintDiamondHeight: NSLayoutConstraint!
    
    @IBOutlet weak var constraintBottomDiamondHeight: NSLayoutConstraint!
    
    @IBOutlet weak var constraintCaratHeight: NSLayoutConstraint!
    
    @IBOutlet weak var constraintBottomCarat: NSLayoutConstraint!
    
    @IBOutlet weak var constraintMetalHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var constraintBottomMetal: NSLayoutConstraint!
    
    
    @IBOutlet weak var gridRtsHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewCustomizeJewelarry: UIView!
    
    @IBOutlet weak var constraintViewJeweHeight: NSLayoutConstraint!
    
    @IBOutlet weak var constraintBangleHeight: NSLayoutConstraint!
    
    
    static var ringOptionId:String=""
    static var ringOptionTypeId:String=""
    static var stoneOptionId:String=""
    static var stoneOptionTypeId:String=""
    //var cProductId:String=""
    
    var productId:String = ""
    var productCategoryId:String = ""
    public var productType:String = ""
    
    static var caratValue = "14K"
    static var metalValue = "Yellow Gold"
    static var diamondValue = "SI-IJ"
    static var ringValue = "12"
    static var braceletProductValue = ""
    static var bangleProductValue = ""
    static var pendentValue = ""
    static var bangleProductId = ""
    static var braceletProductId = ""
    static var pendentProId = ""
    
    
    var sliderImage: [String] = []
    var arrRTS = [ProductDetailItem.Rts_slider]()
    var arrRing = [ProductDetailItem.Ringsize]()
    var arrBangle = [ProductDetailItem.BangleSize]()
    var arrBracelet = [ProductDetailItem.BraceletsSize]()
    var arrPendents = [ProductDetailItem.PendentEarring]()
    var arrDiamond = [ProductDetailItem.Stone_clarity]()
    
    var arrCarat: [String] = []
    var arrMetal : [String] = []
    var arrMetalCopy : [String] = []
    
    var arrDiamondDetail = [ProductDetailItem.Diamonddetails]()
    var arrDiamondDetailRTS = [RTSItem.Diamonddetails]()
    
    @IBOutlet weak var viewRing: UIView!
    @IBOutlet weak var viewPendent: UIView!
    @IBOutlet weak var viewBangle: UIView!
    @IBOutlet weak var viewBracelet: UIView!
    @IBOutlet weak var gridPendent: UICollectionView!
    @IBOutlet weak var gridBracelet: UICollectionView!
    @IBOutlet weak var gridBangle: UICollectionView!
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
    
    
    
    var cProductId = "" , cCategoryId = "" ,cProductType = "", cSku = "", cRingSize = "", cBangle = "", cBracelet = "", cPendentSet = "", cMetalDetail = "", cMetalWeight = "", cStoneDetail = "", cStoneWeight = "", cPrice = "", cQty = "1", cImageUrl = "";
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDownloadCartCount()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getProductDetail(productId: productId, metalCarat: ProductDetailVC.caratValue, metalQualityColor: ProductDetailVC.metalValue, ringSize: "", stoneQuality: ProductDetailVC.diamondValue, bangleProId: "", braceletProId: "", pendentProId: "")
        // Do any additional setup after loading the view.
    }
    func ScrollEnd() {
        let lastSectionIndex = (self.gridDiamond?.numberOfSections)! - 1
        let lastItemIndex = (self.gridDiamond.numberOfItems(inSection: lastSectionIndex)) - 1
        let index =  IndexPath(item: lastItemIndex, section: lastSectionIndex)
        if arrDiamond.count != 0{
            self.gridDiamond!.scrollToItem(at: index, at: UICollectionView.ScrollPosition.bottom, animated: false)
        }
        
    }
    @IBAction func btnBuynow(_ sender: Any) {
        
        cRingSize = ProductDetailVC.ringValue
        cBangle = ProductDetailVC.bangleProductValue
        cBracelet = ProductDetailVC.braceletProductValue
        cPendentSet = ProductDetailVC.pendentValue
        cSku = lblProductSku.text ?? ""
        cCategoryId = productCategoryId
        cProductType = productType
        
        
        if (UserDefaults.standard.string(forKey: USER_SESSION_DATA_KEY)) != nil {
            var ringsOptionId = String()
            var ringsOptionTypeId = String()
            var stonesOptionId = String()
            var stonesOptionTypeId = String()
            
            
            if productType == "simple"{
                ringsOptionId = ""
                ringsOptionTypeId = ""
                stonesOptionId = ""
                stonesOptionTypeId = ""
                
            }else{
                if productCategoryId == RING_ID{
                    ringsOptionId = ProductDetailVC.ringOptionId
                    ringsOptionTypeId = ProductDetailVC.ringOptionTypeId
                }else{
                    ringsOptionId = ""
                    ringsOptionTypeId = ""
                }
                stonesOptionId = ProductDetailVC.stoneOptionId
                stonesOptionTypeId = ProductDetailVC.stoneOptionTypeId
            }
            
            
             self.buyNow(productId: cProductId, customerId: customerId, optionId: ringsOptionId, optionTypeId: ringsOptionTypeId, stoneOptionId: stonesOptionId, stoneOptionTypeId: stonesOptionTypeId, qty: cQty)
            
            
//            self.buyNow(productId: cProductId, customerId: customerId, optionId: ringsOptionId, optionTypeId: ringsOptionTypeId, stonesOptionId: stoneOptionId, stonesOptionTypeId: stoneOptionTypeId, qty: "1")
            
        }
            
        else{
            
            
            
        }
        
    }
    
    @IBAction func btnAddtoCart(_ sender: Any) {
        
        cRingSize = ProductDetailVC.ringValue
        cBangle = ProductDetailVC.bangleProductValue
        cBracelet = ProductDetailVC.braceletProductValue
        cPendentSet = ProductDetailVC.pendentValue
        cSku = lblProductSku.text ?? ""
        cCategoryId = productCategoryId
        cProductType = productType
        
        
        if (UserDefaults.standard.string(forKey: USER_SESSION_DATA_KEY)) != nil {
            var ringsOptionId = String()
            var ringsOptionTypeId = String()
            var stonesOptionId = String()
            var stonesOptionTypeId = String()
            
            
            if productType == "simple"{
                ringsOptionId = ""
                ringsOptionTypeId = ""
                stonesOptionId = ""
                stonesOptionTypeId = ""
                
            }else{
                if productCategoryId == RING_ID{
                    ringsOptionId = ProductDetailVC.ringOptionId
                    ringsOptionTypeId = ProductDetailVC.ringOptionTypeId
                }else{
                    ringsOptionId = ""
                    ringsOptionTypeId = ""
                }
                stonesOptionId = ProductDetailVC.stoneOptionId
                stonesOptionTypeId = ProductDetailVC.stoneOptionTypeId
            }
            
           
            
            self.addToCart(productId: cProductId, customerId: customerId, optionId: ringsOptionId, optionTypeId: ringsOptionTypeId, stoneOptionId: stonesOptionId, stoneOptionTypeId: stonesOptionTypeId, qty: cQty)
            
            
        }
        
        else{
           
            
            
        }
   
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCart(_ sender: Any) {
        
    }
    
    @IBAction func btnSearch(_ sender: Any) {
        let search = self.storyboard?.instantiateViewController(withIdentifier: "SearchVC") as? SearchVC
        navigationController?.pushViewController(search!, animated: true)
    }
    
    func refreshAdapter(){
        self.arrMetal.removeAll()
        self.arrMetal = self.arrMetalCopy
        
        if ProductDetailVC.caratValue == "14K"{
            self.arrMetal = self.arrMetal.filter{$0 != "Platinum(950)"}
            self.gridMetal.reloadData()
        }
        else if ProductDetailVC.caratValue == "18K"{
            self.arrMetal = self.arrMetal.filter{$0 != "Platinum(950)"}
            self.gridMetal.reloadData()
        }
        else if ProductDetailVC.caratValue == "Platinum(950)"{
            self.arrMetal = self.arrMetal.filter{$0 != "Rose Gold"}
            self.arrMetal = self.arrMetal.filter{$0 != "White Gold"}
            self.arrMetal = self.arrMetal.filter{$0 != "Yellow Gold"}
            self.arrMetal = self.arrMetal.filter{$0 != "Two Tone Gold"}
            self.arrMetal = self.arrMetal.filter{$0 != "Three Tone Gold"}
            lblMetalType.text = "( \(ProductDetailVC.caratValue) )"
            self.gridMetal.reloadData()
        }
        
    }
    
    func filterClick(clickAction:String) {
        
        if self.productCategoryId == RING_ID{
            
            self.getProductDetailRefresh(productId: productId, metalCarat: ProductDetailVC.caratValue, metalQualityColor: ProductDetailVC.metalValue, ringSize: ProductDetailVC.ringValue, stoneQuality: ProductDetailVC.diamondValue, bangleProId: "", braceletProId: "", pendentProId: "", clickAction: clickAction)
            
        }else if self.productCategoryId == BRACELETS_ID{
            self.getProductDetailRefresh(productId: productId, metalCarat: ProductDetailVC.caratValue, metalQualityColor: ProductDetailVC.metalValue, ringSize: "", stoneQuality: ProductDetailVC.diamondValue, bangleProId: "", braceletProId: ProductDetailVC.braceletProductId, pendentProId: "", clickAction: clickAction)
            
        }else if self.productCategoryId == BANGLE_ID{
             self.getProductDetailRefresh(productId: productId, metalCarat: ProductDetailVC.caratValue, metalQualityColor: ProductDetailVC.metalValue, ringSize: "", stoneQuality: ProductDetailVC.diamondValue, bangleProId: ProductDetailVC.bangleProductId, braceletProId: "", pendentProId: "", clickAction: clickAction)
            
        }else if self.productCategoryId == PENDANTS_SETS_ID{
            self.getProductDetailRefresh(productId: productId, metalCarat: ProductDetailVC.caratValue, metalQualityColor: ProductDetailVC.metalValue, ringSize: "", stoneQuality: ProductDetailVC.diamondValue, bangleProId: "", braceletProId: "", pendentProId: ProductDetailVC.pendentProId, clickAction: clickAction)
            
        }else{
             self.getProductDetailRefresh(productId: productId, metalCarat: ProductDetailVC.caratValue, metalQualityColor: ProductDetailVC.metalValue, ringSize: "", stoneQuality: ProductDetailVC.diamondValue, bangleProId: "", braceletProId: "", pendentProId: "", clickAction: clickAction)
        }
        
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
                //using gemstone
                self.viewGemstone.isHidden = true
                self.constraintGemstoneHeight.constant = 0
                
                self.viewHeight = self.viewHeight - 270
                
                
                
                let productDetailData=Mapper<ProductDetailItem>().map(JSON: result)
                
                self.navigationItem.title = productDetailData?.product_details?[0].product_name
               
                
                print(productDetailData as Any)
                
                self.productCategoryId=(productDetailData?.category_id!)!
               
                
                self.sliderImage = productDetailData?.slider ?? [""]
                
                self.gridPager.reloadData()
                self.gridSlider.reloadData()
                                
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
                    self.viewRing.isHidden = false
                    self.viewBangle.isHidden = true
                    self.viewBracelet.isHidden = true
                    self.viewPendent.isHidden = true
                }else if self.productCategoryId == BRACELETS_ID{
                    self.viewRing.isHidden = true
                    self.viewBangle.isHidden = true
                    self.viewBracelet.isHidden = false
                    self.viewPendent.isHidden = true
                    
                }else if self.productCategoryId == BANGLE_ID{
                    self.viewRing.isHidden = true
                    self.viewBangle.isHidden = false
                    self.viewBracelet.isHidden = true
                    self.viewPendent.isHidden = true
                }else if self.productCategoryId == PENDANTS_SETS_ID{
                    self.viewRing.isHidden = true
                    self.viewBangle.isHidden = true
                    self.viewBracelet.isHidden = true
                    self.viewPendent.isHidden = false
                }else{
                    self.viewRing.isHidden = true
                    self.viewBangle.isHidden = true
                    self.viewBracelet.isHidden = true
                    self.viewPendent.isHidden = true
                    self.viewAboveDiamond.isHidden = true
                    
//                    self.constraintRingHeight.constant = 0
//                    self.constraintBangleHeight.constant = 0
//                    self.constraintBangleHeight.constant = 0
//                    self.constraintPendentHeight.constant = 0
//                    self.constraintBottonRingHeight.constant = 0
                    
                    self.constraintBangleHeight.constant = 0
                    self.constraintBraceletsHeight.constant = 0
                    self.constraintPendentHeight.constant = 0
                    self.constraintRingHeight.constant = 0
                    self.constraintBottonRingHeight.constant = 0
                    self.constraintDiamondTop.constant = 8
                    
                }
                
                self.productType =  (productDetailData?.products)!
                
                //using for Image slider
                
                if productDetailData?.products == "simple"{
                    self.arrRTS = (productDetailData?.rts_slider)!
                    self.gridRtsSlider.reloadData()
                    
                    self.constraintCustomJewelaryHeight.constant = 0
                    
                    self.constraintBangleHeight.constant = 0
                    self.constraintBraceletsHeight.constant = 0
                    self.constraintPendentHeight.constant = 0
                    self.constraintRingHeight.constant = 0
                    self.constraintBottonRingHeight.constant = 0
                    
                    self.constraintDiamondHeight.constant = 0
                    self.constraintBottomDiamondHeight.constant = 0
                    self.constraintCaratHeight.constant = 0
                    self.constraintBottomCarat.constant = 0
                    self.constraintMetalHeight.constant = 0
                    self.constraintBottomMetal.constant = 0
                    
                    self.viewHeight = self.viewHeight - 432
                 
     
                }
                
                else{
                 
//                    self.constraintCustomJewelaryHeight.constant = 60
//                    self.constraintBangleHeight.constant = 90
//                    self.constraintBraceletsHeight.constant = 90
//                    self.constraintPendentHeight.constant = 90
//                    self.constraintRingHeight.constant = 90
//                    self.constraintBottonRingHeight.constant = 1
//                    self.constraintDiamondHeight.constant = 90
//                    self.constraintBottomDiamondHeight.constant = 1
//                    self.constraintCaratHeight.constant = 90
//                    self.constraintBottomCarat.constant = 1
//                    self.constraintMetalHeight.constant = 90
//                    self.constraintBottomMetal.constant = 1
                    
                    
                    self.cProductId = (productDetailData?.simpleproductid)!
                    
                    
                    self.arrRing = (productDetailData?.ringsize)!
                    self.arrDiamond = (productDetailData?.stone_clarity)!
                    self.arrCarat = (productDetailData?.carat)!
                    self.arrMetal = (productDetailData?.metal)!
                    self.arrBangle = (productDetailData?.bangle_size)!
                    self.arrBracelet = (productDetailData?.bracelets_size)!
                    self.arrPendents = (productDetailData?.pendent_earring)!
                    
                    self.arrMetalCopy = (productDetailData?.metal)!
                    
                    if !self.arrBangle.isEmpty{
                        ProductDetailVC.bangleProductValue = self.arrBangle[0].label!
                        ProductDetailVC.bangleProductId = self.arrBangle[0].product_id!
                        self.gridBangle.reloadData()
                    }
                    
                    if !self.arrBracelet.isEmpty{
                        ProductDetailVC.braceletProductValue = self.arrBracelet[0].label!
                        ProductDetailVC.braceletProductId = self.arrBracelet[0].product_id!
                        self.gridBracelet.reloadData()
                    }
                    
                    if !self.arrPendents.isEmpty{
                        ProductDetailVC.pendentValue = self.arrPendents[0].label!
                        ProductDetailVC.pendentProId = self.arrPendents[0].product_id!
                        self.gridPendent.reloadData()
                    }
                    
                    if !self.arrRing.isEmpty{
                        self.gridRingSize.reloadData()
                        self.gridRingSize?.scrollToItem(at: IndexPath(item: 9, section: 0), at: UICollectionView.ScrollPosition.right, animated: false)
                        
//                        self.getProductDetailRefresh(productId: productId, metalCarat: ProductDetailVC.caratValue, metalQualityColor: ProductDetailVC.metalValue, ringSize: ProductDetailVC.ringValue, stoneQuality: ProductDetailVC.diamondValue, bangleProId: "", braceletProId: "", pendentProId: "", clickAction: "")
                        
                    }
                    
                    self.gridDiamond.reloadData()
                   self.gridDiamond?.scrollToItem(at: IndexPath(item: self.arrDiamond.count - 1, section: 0), at: UICollectionView.ScrollPosition.right, animated: false)
                    
                    self.gridCarat.reloadData()
                    
                    self.refreshAdapter()
//                    self.gridMetal.reloadData()
                    
                    self.arrRTS = (productDetailData?.rts_slider)!
                    
                    if !self.arrRTS.isEmpty{
                        self.gridRtsSlider.reloadData()
                    }else{
                        self.gridRtsHeight.constant = 0
                        self.viewHeight = self.viewHeight - 230
                    }
                    
                }
                
                 self.arrDiamondDetail = (productDetailData?.diamonddetails)!
                 self.tblDiamondDetail.reloadData()
                
                if self.arrDiamondDetail.count > 0{
                    self.viewHeight = self.viewHeight - 290
                    let totalHeightDiamonDetail:Int = self.arrDiamondDetail.count * 290
                    
                    self.constraintDiamondDetailTableHeight.constant = CGFloat(totalHeightDiamonDetail)
                    
                    
                    self.constraintMainHeight.constant = CGFloat(self.viewHeight + totalHeightDiamonDetail)
                    
                    
                    
                }else{
                    
                }
                
                
                
                //product detail
                self.lblProductName.text=productDetailData?.product_details?[0].product_name
             
                self.lblProductSku.text=productDetailData?.product_details?[0].sku
                
                self.lblProductCertificateNo.text=productDetailData?.product_details?[0].certificate_no
              
                self.lblGrandTotal.text=priceFormat2("\(productDetailData?.product_details?[0].price ?? "")")
                
                //metal detail
                self.lblMetalPurity.text=productDetailData?.metaldetails?[0].metalquality
                
                self.lblMetalWeight.text=productDetailData?.metaldetails?[0].metalweight
              
                self.lblMetalEstimatedTotal.text=priceFormat2("\(productDetailData?.metaldetails?[0].metalestimatedprice ?? 0)")
               
                
                //metal and diamone piece and price
                self.lblMetalPrice.text="\(productDetailData?.metalprice! ?? [0])"
               
                self.lblCountDiamond.text="Diamond(\(productDetailData?.diamondmainprice?[0].pices ?? ""))"
                
                self.lblDiamondPrice.text=priceFormat2("\(productDetailData?.diamondmainprice?[0].dimondprice ?? "")")
                
                self.lblFinalPrice.text=priceFormat2("\(productDetailData?.product_details?[0].price ?? "")")
                            
            }
            
        }
        
    }
    
    
    func getProductDetailRefresh(productId:String,metalCarat:String,metalQualityColor:String,ringSize:String,stoneQuality:String,bangleProId:String,braceletProId:String,pendentProId:String,clickAction:String) {
        
        
        let par = ["product_id": productId,
                   "metalcarat": metalCarat,
                   "metalqualitycolor": metalQualityColor,
                   "ringsize": ringSize,
                   "stone_quality": stoneQuality,
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
                
//                self.arrRing.removeAll()
//                self.arrBangle.removeAll()
//                self.arrBracelet.removeAll()
//                self.arrPendents.removeAll()
                
                
                let productDetail=Mapper<ProductDetailItem>().map(JSON: result)
                
                self.cProductId = (productDetail?.simpleproductid)!
                
                if productDetail?.stock == "0"{
                    self.btnAddToCart.isHidden=true
                    self.btnBuyNow.isHidden=true
                    self.btnSoldOut.isHidden=false
                }else{
                    self.btnAddToCart.isHidden=false
                    self.btnBuyNow.isHidden=false
                    self.btnSoldOut.isHidden=true
                }
                
                
                
                //Banner slider
                self.sliderImage = productDetail?.slider ?? [""]
                self.gridPager.reloadData()
                self.gridSlider.reloadData()
                
                //RTS Slider
                self.arrRTS = (productDetail?.rts_slider)!
                if !self.arrRTS.isEmpty{
                    self.gridRtsSlider.reloadData()
                }
                
                //Diamond adapter
                self.arrDiamond = (productDetail?.stone_clarity)!
                self.gridDiamond.reloadData()
                
              
                
//                self.gridDiamond.scrollToItem(at: IndexPath, at: <#T##UICollectionView.ScrollPosition#>, animated: <#T##Bool#>)
              
                if (self.productCategoryId == BANGLE_ID) || (self.productCategoryId == BRACELETS_ID) {
                    
                    if clickAction == "carat"{
                        self.arrBangle = (productDetail?.bangle_size)!
                        self.arrBracelet = (productDetail?.bracelets_size)!
                        
                        if !self.arrBangle.isEmpty{
                            ProductDetailVC.bangleProductValue = self.arrBangle[0].label!
                            ProductDetailVC.bangleProductId = self.arrBangle[0].product_id!
                            self.gridBangle.reloadData()
                        }
                        
                        if !self.arrBracelet.isEmpty{
                            ProductDetailVC.braceletProductValue = self.arrBracelet[0].label!
                            ProductDetailVC.braceletProductId = self.arrBracelet[0].product_id!
                            self.gridBracelet.reloadData()
                        }
                        
                    }
                    
                }
            
                //Diamond Detail
                self.arrDiamondDetail = (productDetail?.diamonddetails)!
                self.tblDiamondDetail.reloadData()
       
                /*
                //product detail
                self.lblProductName.text=productDetail?.product_details?[0].product_name
                
                self.lblProductSku.text=productDetail?.product_details?[0].sku
                
                self.lblProductCertificateNo.text=productDetail?.product_details?[0].certificate_no
                
                self.lblGrandTotal.text=productDetail?.product_details?[0].price
                
                //metal detail
                self.lblMetalPurity.text=productDetail?.metaldetails?[0].metalquality
                
                self.lblMetalWeight.text=productDetail?.metaldetails?[0].metalweight
                
                self.lblMetalEstimatedTotal.text="\(productDetail?.metaldetails?[0].metalestimatedprice ?? 0)"
                
                
                //metal and diamone piece and price
                self.lblMetalPrice.text="\(productDetail?.metalprice! ?? [0])"
                
                self.lblCountDiamond.text="Diamond(\(productDetail?.diamondmainprice?[0].pices ?? ""))"
                
                self.lblDiamondPrice.text="\(productDetail?.diamondmainprice?[0].dimondprice ?? "")"
                
                self.lblFinalPrice.text="\(productDetail?.product_details?[0].price ?? "")"
                */
                
                
                
                
                //product detail
                self.lblProductName.text=productDetail?.product_details?[0].product_name
                
                self.lblProductSku.text=productDetail?.product_details?[0].sku
                
                self.lblProductCertificateNo.text=productDetail?.product_details?[0].certificate_no
                
                self.lblGrandTotal.text=priceFormat2("\(productDetail?.product_details?[0].price ?? "")")
                
                //metal detail
                self.lblMetalPurity.text=productDetail?.metaldetails?[0].metalquality
                
                self.lblMetalWeight.text=productDetail?.metaldetails?[0].metalweight
                
                self.lblMetalEstimatedTotal.text=priceFormat2("\(productDetail?.metaldetails?[0].metalestimatedprice ?? 0)")
                
             
                
                //metal and diamone piece and price
                self.lblMetalPrice.text="\(productDetail?.metalprice! ?? [0])"
                
                self.lblCountDiamond.text="Diamond(\(productDetail?.diamondmainprice?[0].pices ?? ""))"
                
                self.lblDiamondPrice.text=priceFormat2("\(productDetail?.diamondmainprice?[0].dimondprice ?? "")")
                
                self.lblFinalPrice.text=priceFormat2("\(productDetail?.product_details?[0].price ?? "")")
                
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
                self.showAlert(title: SUCCESS, message: result["message"] as? String ?? "")
                 self.getDownloadCartCount()
            }
            
        }
        
        
    }
    
    func buyNow(productId:String,customerId:String,optionId:String,optionTypeId:String,stoneOptionId:String,stoneOptionTypeId:String,qty:String){
        
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
//                self.showAlert(title: SUCCESS, message: result["message"] as? String ?? "")
                
                let cart = self.storyboard?.instantiateViewController(withIdentifier: "CartVC") as? CartVC
//                productDetail?.productId=self.arrList[indexPath.row].entity_id!
                self.navigationController?.pushViewController(cart!, animated: true)
                
            }
            
        }
        
        
    }
    
    
    func rtsProductClick(productId:String)  {
        print(productId)
        
        let par = ["product_id": productId]
        
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiRtsProductClick(params:par as [String : AnyObject]) { (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
               
                
            } else {
                
                 let rtsDetail=Mapper<RTSItem>().map(JSON: result)
                
               // self.productType =  (rtsDetail?.products)!
                
                if rtsDetail?.stock == "0"{
                    self.btnAddToCart.isHidden=true
                    self.btnBuyNow.isHidden=true
                    self.btnSoldOut.isHidden=false
                }else{
                    self.btnAddToCart.isHidden=false
                    self.btnBuyNow.isHidden=false
                    self.btnSoldOut.isHidden=true
                }
                
//
//                 self.arrDiamondDetailRTS = (rtsDetail?.diamonddetails)!
//                 self.tblDiamondDetail.reloadData()
                
               
                
                //product detail
                self.lblProductName.text=rtsDetail?.product_details?[0].product_name
                
                self.lblProductSku.text=rtsDetail?.product_details?[0].sku
                
                self.lblProductCertificateNo.text=rtsDetail?.product_details?[0].certificate_no
                
                self.lblGrandTotal.text=priceFormat2("\(rtsDetail?.product_details?[0].price ?? "")")
                
                //metal detail
                self.lblMetalPurity.text=rtsDetail?.metaldetails?[0].metalquality
                
                self.lblMetalWeight.text=rtsDetail?.metaldetails?[0].metalweight
                
                self.lblMetalEstimatedTotal.text=priceFormat2("\(rtsDetail?.metaldetails?[0].metalestimatedprice ?? 0)")
                
                //metal and diamone piece and price
                self.lblMetalPrice.text="\(rtsDetail?.metalprice! ?? [0])"
                
                self.lblCountDiamond.text="Diamond(\(rtsDetail?.diamondmainprice?[0].pices ?? ""))"
                
                self.lblDiamondPrice.text=priceFormat2("\(rtsDetail?.diamondmainprice?[0].dimondprice ?? "")")
                
                self.lblFinalPrice.text=priceFormat2("\(rtsDetail?.product_details?[0].price ?? "")")
               
            }
            
        }
    }
    
}


extension ProductDetailVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    
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
        else if collectionView==self.gridBangle{
            return self.arrBangle.count
        }
        else if collectionView==self.gridBracelet{
            return self.arrBracelet.count
        }
        else if collectionView==self.gridPendent{
            return self.arrPendents.count
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
            return cell
        }
            
        else if collectionView==self.gridRtsSlider{
            let cell = self.gridRtsSlider.dequeueReusableCell(withReuseIdentifier: "RTSCell", for: indexPath) as! RTSCell
            print(productId)
            print(self.arrRTS[indexPath.row].entity_id as Any)
            
            cell.rtsData = self.arrRTS[indexPath.row]
            
            return cell
        }
            
        else if collectionView==self.gridRingSize{
            let cell = self.gridRingSize.dequeueReusableCell(withReuseIdentifier: "RingCell", for: indexPath) as! RingCell
            cell.ringSize = self.arrRing[indexPath.row]
            
            
            
            cell.actionClick = {
                ProductDetailVC.ringValue = self.arrRing[indexPath.row].title!
                
                ProductDetailVC.ringOptionId=self.arrRing[indexPath.row].option_id!
                ProductDetailVC.ringOptionTypeId=self.arrRing[indexPath.row].option_type_id!
                
                self.filterClick(clickAction: "")
                self.gridRingSize.reloadData()
                
               
            }
            
            return cell
        }
            
        else if collectionView==self.gridBangle{
            let cell = self.gridBangle.dequeueReusableCell(withReuseIdentifier: "BangleCell", for: indexPath) as! BangleCell
            cell.bangleData = self.arrBangle[indexPath.row]
            cell.actionClick = {
                ProductDetailVC.bangleProductValue = self.arrBangle[indexPath.row].label!
                ProductDetailVC.bangleProductId = self.arrBangle[indexPath.row].product_id!
                
                 self.filterClick(clickAction: "")
                self.gridBangle.reloadData()
                
              
            }
            
            return cell
        }
            
        else if collectionView==self.gridBracelet{
            let cell = self.gridBracelet.dequeueReusableCell(withReuseIdentifier: "BraceletsCell", for: indexPath) as! BraceletsCell
            cell.braceletData = self.arrBracelet[indexPath.row]
            cell.actionClick = {
                ProductDetailVC.braceletProductValue = self.arrBracelet[indexPath.row].label!
                ProductDetailVC.braceletProductId = self.arrBracelet[indexPath.row].product_id!
                self.filterClick(clickAction: "")
                self.gridBracelet.reloadData()
                
               
            }
            
            return cell
        }
            
            
        else if collectionView==self.gridPendent{
            let cell = self.gridPendent.dequeueReusableCell(withReuseIdentifier: "PendentCell", for: indexPath) as! PendentCell
            cell.pendentData = self.arrPendents[indexPath.row]
            cell.actionClick = {
                ProductDetailVC.pendentValue = self.arrPendents[indexPath.row].label!
                ProductDetailVC.pendentProId = self.arrPendents[indexPath.row].product_id!
               self.filterClick(clickAction: "")
                self.gridPendent.reloadData()
                
                
            }
            
            return cell
        }
            
        else if collectionView==self.gridDiamond{
            let cell = self.gridDiamond.dequeueReusableCell(withReuseIdentifier: "DiamondCell", for: indexPath) as! DiamondCell
            cell.diamondData = self.arrDiamond[indexPath.row]
            
            cell.actionClick = {
                ProductDetailVC.diamondValue = self.arrDiamond[indexPath.row].title!
                ProductDetailVC.stoneOptionId=self.arrDiamond[indexPath.row].option_id!
                ProductDetailVC.stoneOptionTypeId=self.arrDiamond[indexPath.row].option_type_id!
                 self.filterClick(clickAction: "")
                self.gridDiamond.reloadData()
               
            }
            
            return cell
        }
            
        else if collectionView==self.gridCarat{
            let cell = self.gridCarat.dequeueReusableCell(withReuseIdentifier: "CaratCell", for: indexPath) as! CaratCell
            cell.caratData = [self.arrCarat[indexPath.row]]
            
            cell.actionClick = {
                ProductDetailVC.caratValue = self.arrCarat[indexPath.row]
                
                if (ProductDetailVC.caratValue == "Platinum(950)"){
                    ProductDetailVC.metalValue = "Platinum(950)"
                    self.refreshAdapter()
                  //  ((ProductDetailAct) activity).refreshAdapter();
                    
                }else{
                    
                    ProductDetailVC.metalValue = "Yellow Gold"
                    self.refreshAdapter()
                    
                 //   ((ProductDetailAct) activity).refreshAdapter();
                    
                }
                
                self.filterClick(clickAction: "carat")
                self.gridCarat.reloadData()
                
                
            }
            
            
            return cell
        }
            
        else if collectionView==self.gridMetal{
            let cell = self.gridMetal.dequeueReusableCell(withReuseIdentifier: "MetalCell", for: indexPath) as! MetalCell
            cell.metalData = [self.arrMetal[indexPath.row]]
            cell.actionClick = {
                ProductDetailVC.metalValue = self.arrMetal[indexPath.row]
                self.filterClick(clickAction: "")
                self.gridMetal.reloadData()
                
            }
            
            
            return cell
        }
            
        else{
            let cell = self.gridSlider.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as! SliderCell
            cell.slider = [self.sliderImage[indexPath.row]]
           
            return cell
        }
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView==self.gridPager{
            print(indexPath.row)
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView==self.gridPager{
            
        }
            
        else if collectionView == self.gridSlider {
            self.gridPager.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
            
        else if collectionView==self.gridRtsSlider{
            self.cProductId = arrRTS[indexPath.row].entity_id!
            print(self.arrRTS[indexPath.row].entity_id!)
            var i:Int=0
            for _ in self.arrRTS{
                
                if i != indexPath.row{
                     arrRTS[i].isSelected = false
                }else{
                    arrRTS[i].isSelected = true
                }
                i += 1
           
            }
            
            cProductId = self.arrRTS[indexPath.row].entity_id ?? ""
            cSku = self.arrRTS[indexPath.row].original_sku ?? ""
            cRingSize = self.arrRTS[indexPath.row].rts_ring_size ?? ""
            cBangle = self.arrRTS[indexPath.row].rts_bangle_size ?? ""
            cBracelet = self.arrRTS[indexPath.row].rts_bracelet_size ?? ""
            cMetalDetail = self.arrRTS[indexPath.row].metal_quality_value ?? ""
            cStoneDetail = self.arrRTS[indexPath.row].rts_stone_quality ?? ""
            cPrice = self.arrRTS[indexPath.row].custom_price ?? ""
            
            print(self.arrRTS[indexPath.row].entity_id!)
            self.rtsProductClick(productId: self.arrRTS[indexPath.row].entity_id!)
            
            self.gridRtsSlider.reloadData()
            
            
        }
            
        else if collectionView==self.gridRingSize{
          
        }
            
        else if collectionView==self.gridDiamond{
            
        }
            
        else if collectionView==self.gridCarat{
            
        }
            
        else if collectionView==self.gridMetal{
           
        }
            
        else{
           
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        if collectionView==self.gridDiamond{
//            let str = self.arrDiamond[indexPath.row].title
//            let width = str!.size(withAttributes: [
//                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)
//                ])
//             return CGSize(width: width.width + 20, height : 50)
//        }
//
//        return CGSize(width: 100, height : 100)
        
        
        if collectionView==self.gridPager{
           return CGSize(width: gridPager.frame.width, height :237)
        }
            
        else if collectionView==self.gridRtsSlider{
          
            return CGSize(width: 136, height :178)
        }
            
        else if collectionView==self.gridRingSize{
            let str = self.arrRing[indexPath.row].title
            let width = str!.size(withAttributes: [
                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)
                ])
            return CGSize(width: width.width + CGFloat(w), height : CGFloat(h))
        }
            
        else if collectionView==self.gridBangle{
            let str = self.arrBangle[indexPath.row].label
            let width = str!.size(withAttributes: [
                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)
                ])
            return CGSize(width: width.width + CGFloat(w), height : CGFloat(h))
        }
            
        else if collectionView==self.gridBracelet{
            let str = self.arrBracelet[indexPath.row].label
            let width = str!.size(withAttributes: [
                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)
                ])
            return CGSize(width: width.width + CGFloat(w), height : CGFloat(h))
        }
            
        else if collectionView==self.gridPendent{
            let str = self.arrPendents[indexPath.row].label
            let width = str!.size(withAttributes: [
                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)
                ])
            return CGSize(width: width.width + CGFloat(w), height : CGFloat(h))
        }
            
        else if collectionView==self.gridDiamond{
            let str = self.arrDiamond[indexPath.row].title
            let width = str!.size(withAttributes: [
                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)
                ])
            return CGSize(width: width.width + CGFloat(w), height : CGFloat(h))
        }
            
        else if collectionView==self.gridCarat{
            let str = self.arrCarat[indexPath.row]
            let width = str.size(withAttributes: [
                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)
                ])
            return CGSize(width: width.width + CGFloat(w), height : CGFloat(h))
        }
            
        else if collectionView==self.gridMetal{
            let str = self.arrMetal[indexPath.row]
            let width = str.size(withAttributes: [
                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)
                ])
            return CGSize(width: width.width + CGFloat(w), height : CGFloat(h))
        }
            
        else{
             return CGSize(width:93, height : 84)
        }
        
        
        
    }
    
  
}

extension ProductDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrDiamondDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = self.tblDiamondDetail.dequeueReusableCell(withIdentifier: "DiamondDetailCell", for: indexPath) as? DiamondDetailCell
        
        cell?.diamondDetail = self.arrDiamondDetail[indexPath.row]
        cell?.lblDiamondIndex.text = "Diamond \(indexPath.row + 1)"
   
        return cell!
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
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

extension ProductDetailVC: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = self.gridPager.contentOffset
        visibleRect.size = self.gridPager.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        guard let indexPath = self.gridPager.indexPathForItem(at: visiblePoint) else { return }
        
        print(indexPath.row)
        
    }
    
}
