import UIKit

class DiamondCell: UICollectionViewCell {
    
    @IBOutlet weak var btnDiamond: UIButtonX!
    
//    var data = ProductDetailVC()
    
    var actionClick: (() -> Void)? = nil
    var diamondData : ProductDetailItem.Stone_clarity?{
        didSet{
            
            
            //retrieve from UserDefaults
            if (UserDefaults.standard.string(forKey: THEME_USEDEFAULTS)) != nil {
                let theme = UserDefaults.standard.string(forKey: THEME_USEDEFAULTS) ?? ""
                if theme == BLACK_THEME_KEY{
                    if diamondData?.title == ProductDetailVC.diamondValue{
                        btnDiamond.borderColor = UIColor.selectButtonColor
                        btnDiamond.borderWidth = 1
                        btnDiamond.setTitleColor(UIColor.selectButtonColor, for: .normal)
                        btnDiamond.backgroundColor = UIColor.dmlBlack
                        ProductDetailVC.stoneOptionId = (diamondData?.option_id)!
                        ProductDetailVC.stoneOptionTypeId = (diamondData?.option_type_id)!
                        
                    }else{
                        btnDiamond.borderColor = UIColor.transactionLineColorBlack
                        btnDiamond.borderWidth = 1
                        btnDiamond.setTitleColor(UIColor.dmlWhite, for: .normal)
                        btnDiamond.backgroundColor = UIColor.dmlBlack
                    }
                }else if theme == WHITE_THEME_KEY{
                    if diamondData?.title == ProductDetailVC.diamondValue{
                        btnDiamond.borderColor = UIColor.selectButtonColor
                        btnDiamond.borderWidth = 1
                        btnDiamond.setTitleColor(UIColor.selectButtonColor, for: .normal)
                        btnDiamond.backgroundColor = UIColor.dmlWhite
                        ProductDetailVC.stoneOptionId = (diamondData?.option_id)!
                        ProductDetailVC.stoneOptionTypeId = (diamondData?.option_type_id)!
                        
                    }else{
                        btnDiamond.borderColor = UIColor.unSelectButtonColor
                        btnDiamond.borderWidth = 1
                        btnDiamond.setTitleColor(UIColor.unSelectButtonColor, for: .normal)
                        btnDiamond.backgroundColor = UIColor.dmlWhite
                    }
                    
                }else{
                    if diamondData?.title == ProductDetailVC.diamondValue{
                        btnDiamond.borderColor = UIColor.selectButtonColor
                        btnDiamond.borderWidth = 1
                        btnDiamond.setTitleColor(UIColor.selectButtonColor, for: .normal)
                        btnDiamond.backgroundColor = UIColor.dmlWhite
                        ProductDetailVC.stoneOptionId = (diamondData?.option_id)!
                        ProductDetailVC.stoneOptionTypeId = (diamondData?.option_type_id)!
                        
                    }else{
                        btnDiamond.borderColor = UIColor.unSelectButtonColor
                        btnDiamond.borderWidth = 1
                        btnDiamond.setTitleColor(UIColor.unSelectButtonColor, for: .normal)
                        btnDiamond.backgroundColor = UIColor.dmlWhite
                    }
                }
                
            }
            
            
           
            
            btnDiamond.setTitle(diamondData?.title, for: .normal)
        }
    }
    
    @IBAction func btnDiamond(_ sender: Any) {
        actionClick?()
    }
}
