import UIKit

class BangleCell: UICollectionViewCell {
    var actionClick: (() -> Void)? = nil
    @IBOutlet weak var btnBangle: UIButtonX!
    var bangleData:ProductDetailItem.BangleSize?{
        didSet{
            
            //retrieve from UserDefaults
            if (UserDefaults.standard.string(forKey: THEME_USEDEFAULTS)) != nil {
                let theme = UserDefaults.standard.string(forKey: THEME_USEDEFAULTS) ?? ""
                if theme == BLACK_THEME_KEY{
                    if bangleData?.label == ProductDetailVC.bangleProductValue{
                        btnBangle.borderColor = UIColor.selectButtonColor
                        btnBangle.borderWidth = 1
                        btnBangle.setTitleColor(UIColor.selectButtonColor, for: .normal)
                        btnBangle.backgroundColor = UIColor.dmlBlack
                        
                    }else{
                        btnBangle.borderColor = UIColor.transactionLineColorBlack
                        btnBangle.borderWidth = 1
                        btnBangle.setTitleColor(UIColor.dmlWhite, for: .normal)
                        btnBangle.backgroundColor = UIColor.dmlBlack
                        
                    }
                }else if theme == WHITE_THEME_KEY{
                 
                    if bangleData?.label == ProductDetailVC.bangleProductValue{
                        btnBangle.borderColor = UIColor.selectButtonColor
                        btnBangle.borderWidth = 1
                        btnBangle.setTitleColor(UIColor.selectButtonColor, for: .normal)
                        btnBangle.backgroundColor = UIColor.dmlWhite
                        
                    }else{
                        btnBangle.borderColor = UIColor.unSelectButtonColor
                        btnBangle.borderWidth = 1
                        btnBangle.setTitleColor(UIColor.unSelectButtonColor, for: .normal)
                        btnBangle.backgroundColor = UIColor.dmlWhite
                        
                    }
                }else{
                    if bangleData?.label == ProductDetailVC.bangleProductValue{
                        btnBangle.borderColor = UIColor.selectButtonColor
                        btnBangle.borderWidth = 1
                        btnBangle.setTitleColor(UIColor.selectButtonColor, for: .normal)
                        btnBangle.backgroundColor = UIColor.dmlWhite
                        
                    }else{
                        btnBangle.borderColor = UIColor.unSelectButtonColor
                        btnBangle.borderWidth = 1
                        btnBangle.setTitleColor(UIColor.unSelectButtonColor, for: .normal)
                        btnBangle.backgroundColor = UIColor.dmlWhite
                        
                    }
                }
                
            }
            
           
            
            btnBangle.setTitle(bangleData?.label, for: .normal)
            
            
        }
    }
    
    @IBAction func btnBangleClick(_ sender: Any) {
        actionClick?()
    }
}
