import UIKit

class RingCell: UICollectionViewCell {
    
    @IBOutlet weak var btnRingSize: UIButtonX!
    
//    var data = ProductDetailVC()
    
    var actionClick: (() -> Void)? = nil
    var ringSize : ProductDetailItem.Ringsize?{
        didSet{
            
            //retrieve from UserDefaults
            if (UserDefaults.standard.string(forKey: THEME_USEDEFAULTS)) != nil {
                let theme = UserDefaults.standard.string(forKey: THEME_USEDEFAULTS) ?? ""
                if theme == BLACK_THEME_KEY{
                    
                    if ringSize?.title == ProductDetailVC.ringValue{
                        btnRingSize.borderColor = UIColor.selectButtonColor
                        btnRingSize.borderWidth = 1
                        btnRingSize.setTitleColor(UIColor.selectButtonColor, for: .normal)
                        btnRingSize.backgroundColor = UIColor.dmlBlack
                        ProductDetailVC.ringOptionId = (ringSize?.option_id)!
                        ProductDetailVC.ringOptionTypeId = (ringSize?.option_type_id)!
                    }else{
                        btnRingSize.borderColor = UIColor.transactionLineColorBlack
                        btnRingSize.borderWidth = 1
                        btnRingSize.setTitleColor(UIColor.dmlWhite, for: .normal)
                        btnRingSize.backgroundColor = UIColor.dmlBlack
                    }
                    
                }else if theme == WHITE_THEME_KEY{
                    if ringSize?.title == ProductDetailVC.ringValue{
                        btnRingSize.borderColor = UIColor.selectButtonColor
                        btnRingSize.borderWidth = 1
                        btnRingSize.setTitleColor(UIColor.selectButtonColor, for: .normal)
                        btnRingSize.backgroundColor = UIColor.dmlWhite
                        ProductDetailVC.ringOptionId = (ringSize?.option_id)!
                        ProductDetailVC.ringOptionTypeId = (ringSize?.option_type_id)!
                    }else{
                        btnRingSize.borderColor = UIColor.unSelectButtonColor
                        btnRingSize.borderWidth = 1
                        btnRingSize.setTitleColor(UIColor.unSelectButtonColor, for: .normal)
                        btnRingSize.backgroundColor = UIColor.dmlWhite
                    }
                    
                }else{
                    if ringSize?.title == ProductDetailVC.ringValue{
                        btnRingSize.borderColor = UIColor.selectButtonColor
                        btnRingSize.borderWidth = 1
                        btnRingSize.setTitleColor(UIColor.selectButtonColor, for: .normal)
                        btnRingSize.backgroundColor = UIColor.dmlWhite
                        ProductDetailVC.ringOptionId = (ringSize?.option_id)!
                        ProductDetailVC.ringOptionTypeId = (ringSize?.option_type_id)!
                    }else{
                        btnRingSize.borderColor = UIColor.unSelectButtonColor
                        btnRingSize.borderWidth = 1
                        btnRingSize.setTitleColor(UIColor.unSelectButtonColor, for: .normal)
                        btnRingSize.backgroundColor = UIColor.dmlWhite
                        
                    }
                }
                
            }
            
            
            
           
            
            btnRingSize.setTitle(ringSize?.title, for: .normal)
            
            
        }
    }
    
    @IBAction func btnRingClick(_ sender: Any) {
        actionClick?()
    }
    
}
