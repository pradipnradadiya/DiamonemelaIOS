import UIKit

class RTSCell: UICollectionViewCell {
    
    @IBOutlet weak var lblSizeHeading: UILabel!
    @IBOutlet weak var lblDiamondWeightHeading: UILabel!
    @IBOutlet weak var lblStoneHeading: UILabel!
    @IBOutlet weak var lblMetailHeading: UILabel!
    @IBOutlet weak var viewBack: UIViewX!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblDiamondWeight: UILabel!
    @IBOutlet weak var lblStone: UILabel!
    @IBOutlet weak var lblMetal: UILabel!
    
    
    let productDetailInstance = ProductDetailVC();
   
    var flag = 0
    var rtsData:ProductDetailItem.Rts_slider?{
        didSet{
            
           
            
            
            if flag==0{
                
                if productDetailInstance.productType == "simple"{
                    
                    if rtsData?.entity_id == productDetailInstance.productId {
                        rtsData?.isSelected = true
                        flag = 1
                        productDetailInstance.cProductId = rtsData?.entity_id ?? ""
                        productDetailInstance.cSku = rtsData?.original_sku ?? ""
                        productDetailInstance.cRingSize = rtsData?.rts_ring_size ?? ""
                        productDetailInstance.cBangle = rtsData?.rts_bangle_size ?? ""
                        productDetailInstance.cBracelet = rtsData?.rts_bracelet_size ?? ""
                        productDetailInstance.cMetalDetail = rtsData?.metal_quality_value ?? ""
                        productDetailInstance.cStoneDetail = rtsData?.rts_stone_quality ?? ""
                        productDetailInstance.cPrice = rtsData?.custom_price ?? ""
                        productDetailInstance.rtsProductClick(productId: rtsData?.entity_id ?? "")
                        
                    }
                    
                }
                
                
            }
            
            //retrieve from UserDefaults
            if (UserDefaults.standard.string(forKey: THEME_USEDEFAULTS)) != nil {
                let theme = UserDefaults.standard.string(forKey: THEME_USEDEFAULTS) ?? ""
                if theme == BLACK_THEME_KEY{
                    //retrieve from UserDefaults
                    if (UserDefaults.standard.string(forKey: THEME_USEDEFAULTS)) != nil {
                        let theme = UserDefaults.standard.string(forKey: THEME_USEDEFAULTS) ?? ""
                        if theme == BLACK_THEME_KEY{
                            
                            if rtsData?.isSelected == true{
                                //viewBack.backgroundColor = UIColor.selectButtonColor
                                viewBack.firstColor = UIColor.transactionLineColorBlack
                                viewBack.secondColor = UIColor.transactionRoundBackBlack
                                viewBack.borderWidth = 0
                                
                                lblMetal.textColor = UIColor.white
                                lblStone.textColor = UIColor.white
                                lblDiamondWeight.textColor = UIColor.white
                                lblSize.textColor = UIColor.white
                                
                                lblMetailHeading.textColor = UIColor.white
                                lblStoneHeading.textColor = UIColor.white
                                lblDiamondWeightHeading.textColor = UIColor.white
                                lblSizeHeading.textColor = UIColor.white
                                
                            }else{
                                viewBack.firstColor = UIColor.black
                                viewBack.secondColor = UIColor.black
                                viewBack.borderWidth = 1
                                viewBack.borderColor = UIColor.dmlWhite
                                //                                        viewBack.backgroundColor = UIColor.dmlBlack
                                lblMetal.textColor = UIColor.white
                                lblStone.textColor = UIColor.white
                                lblDiamondWeight.textColor = UIColor.white
                                lblSize.textColor = UIColor.white
                                
                                lblMetailHeading.textColor = UIColor.white
                                lblStoneHeading.textColor = UIColor.white
                                lblDiamondWeightHeading.textColor = UIColor.white
                                lblSizeHeading.textColor = UIColor.white
                            }
                            
                        }else if theme == WHITE_THEME_KEY{
                            if rtsData?.isSelected == true{
                                //viewBack.backgroundColor = UIColor.selectButtonColor
                                viewBack.firstColor = UIColor.rtsStartColor
                                viewBack.secondColor = UIColor.rtsEndColor
                                viewBack.borderWidth = 0
                                
                                lblMetal.textColor = UIColor.white
                                lblStone.textColor = UIColor.white
                                lblDiamondWeight.textColor = UIColor.white
                                lblSize.textColor = UIColor.white
                                
                                lblMetailHeading.textColor = UIColor.white
                                lblStoneHeading.textColor = UIColor.white
                                lblDiamondWeightHeading.textColor = UIColor.white
                                lblSizeHeading.textColor = UIColor.white
                                
                            }else{
                                viewBack.firstColor = UIColor.white
                                viewBack.secondColor = UIColor.white
                                viewBack.borderWidth = 1
                                lblMetal.textColor = UIColor.black
                                lblStone.textColor = UIColor.black
                                lblDiamondWeight.textColor = UIColor.black
                                lblSize.textColor = UIColor.black
                                
                                lblMetailHeading.textColor = UIColor.black
                                lblStoneHeading.textColor = UIColor.black
                                lblDiamondWeightHeading.textColor = UIColor.black
                                lblSizeHeading.textColor = UIColor.black
                            }
                            
                        }else{
                            if rtsData?.isSelected == true{
                                //viewBack.backgroundColor = UIColor.selectButtonColor
                                viewBack.firstColor = UIColor.rtsStartColor
                                viewBack.secondColor = UIColor.rtsEndColor
                                viewBack.borderWidth = 0
                                
                                lblMetal.textColor = UIColor.white
                                lblStone.textColor = UIColor.white
                                lblDiamondWeight.textColor = UIColor.white
                                lblSize.textColor = UIColor.white
                                
                                lblMetailHeading.textColor = UIColor.white
                                lblStoneHeading.textColor = UIColor.white
                                lblDiamondWeightHeading.textColor = UIColor.white
                                lblSizeHeading.textColor = UIColor.white
                                
                            }else{
                                viewBack.firstColor = UIColor.white
                                viewBack.secondColor = UIColor.white
                                viewBack.borderWidth = 1
                                lblMetal.textColor = UIColor.black
                                lblStone.textColor = UIColor.black
                                lblDiamondWeight.textColor = UIColor.black
                                lblSize.textColor = UIColor.black
                                
                                lblMetailHeading.textColor = UIColor.black
                                lblStoneHeading.textColor = UIColor.black
                                lblDiamondWeightHeading.textColor = UIColor.black
                                lblSizeHeading.textColor = UIColor.black
                            }
                        }
                        
                    }
                    
                }else if theme == WHITE_THEME_KEY{
                    if rtsData?.isSelected == true{
                        //viewBack.backgroundColor = UIColor.selectButtonColor
                        viewBack.firstColor = UIColor.rtsStartColor
                        viewBack.secondColor = UIColor.rtsEndColor
                        viewBack.borderWidth = 0
                        
                        lblMetal.textColor = UIColor.white
                        lblStone.textColor = UIColor.white
                        lblDiamondWeight.textColor = UIColor.white
                        lblSize.textColor = UIColor.white
                        
                        lblMetailHeading.textColor = UIColor.white
                        lblStoneHeading.textColor = UIColor.white
                        lblDiamondWeightHeading.textColor = UIColor.white
                        lblSizeHeading.textColor = UIColor.white
                        
                    }else{
                        viewBack.firstColor = UIColor.white
                        viewBack.secondColor = UIColor.white
                        viewBack.borderWidth = 1
                        lblMetal.textColor = UIColor.black
                        lblStone.textColor = UIColor.black
                        lblDiamondWeight.textColor = UIColor.black
                        lblSize.textColor = UIColor.black
                        
                        lblMetailHeading.textColor = UIColor.black
                        lblStoneHeading.textColor = UIColor.black
                        lblDiamondWeightHeading.textColor = UIColor.black
                        lblSizeHeading.textColor = UIColor.black
                    }
                }else{
                    if rtsData?.isSelected == true{
                        //viewBack.backgroundColor = UIColor.selectButtonColor
                        viewBack.firstColor = UIColor.rtsStartColor
                        viewBack.secondColor = UIColor.rtsEndColor
                        viewBack.borderWidth = 0
                        
                        lblMetal.textColor = UIColor.white
                        lblStone.textColor = UIColor.white
                        lblDiamondWeight.textColor = UIColor.white
                        lblSize.textColor = UIColor.white
                        
                        lblMetailHeading.textColor = UIColor.white
                        lblStoneHeading.textColor = UIColor.white
                        lblDiamondWeightHeading.textColor = UIColor.white
                        lblSizeHeading.textColor = UIColor.white
                        
                    }else{
                        viewBack.firstColor = UIColor.white
                        viewBack.secondColor = UIColor.white
                        viewBack.borderWidth = 1
                        lblMetal.textColor = UIColor.black
                        lblStone.textColor = UIColor.black
                        lblDiamondWeight.textColor = UIColor.black
                        lblSize.textColor = UIColor.black
                        
                        lblMetailHeading.textColor = UIColor.black
                        lblStoneHeading.textColor = UIColor.black
                        lblDiamondWeightHeading.textColor = UIColor.black
                        lblSizeHeading.textColor = UIColor.black
                    }
                }
                
            }
            
            
            lblMetal.text=rtsData?.metal_quality_value
            lblStone.text=rtsData?.rts_stone_quality
            lblDiamondWeight.text="\(rtsData?.diamond_weight ?? 0)"
            
        }
    }
    
}
